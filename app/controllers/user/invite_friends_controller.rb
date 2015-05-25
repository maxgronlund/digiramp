class User::InviteFriendsController < ApplicationController
  before_action :access_user
  
  def new
  end

  def create
    
    invitations_send_to_index = 0
    invitations_send_to       = []
    
    already_invited_index     = 0
    already_invited           = []
    
    params[:emails].split(',').each do |raw_email|
      raw_email.split(' ').each do |email|
        if email = EmailSanitizer.saintize( email )
          client = Client.where(email: email, user_id: @user.id).first_or_create(email: email, user_id: @user.id, account_id: @user.account_id)
          
          if client.full_name == ' '
            client.name =  User.create_uniq_user_name_from_email( email )  
            client.save!
          end
          
          unless @client_invitation = ClientInvitation.where( account_id: @user.account_id, client_id: client.id).first
                 client_invitation = ClientInvitation.create( account_id: @user.account_id, 
                                                              client_id:  client.id,
                                                              user_id:    @user.id,
                                                              status:     'Invited',
                                                              uuid:       UUIDTools::UUID.timestamp_create().to_s,
                                                              email:      client.email )
             client_invitation.send_one_with_avatar
             invitations_send_to[invitations_send_to_index] = email 
             invitations_send_to_index                      += 1
          else
            already_invited[already_invited_index]  = email
            already_invited_index     += 1
          end

        end
      end
    end
    @invitations_send_to  = invitations_send_to
    @already_invited      = already_invited
    @invitations_send     = invitations_send_to_index
  end
end
