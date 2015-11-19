class InvitesController < ApplicationController

	def index
    return forbidden unless current_user
    ap session
    provider =  params[:provider]
    
    contacts  = request.env['omnicontacts.contacts']
    _user      = request.env['omnicontacts.user']
    unless user = User.get_by_email(_user[:email])
      user = current_user
    end

    @client_import = ClientImport.create(
      user_id:      user.id,
      account_id:   user.account_id,
      user_uuid:    user.uuid,
      source:       'Google mail'
    )
    @client_group = ClientGroup.create(
      title:            "Invitation from #{provider} #{@client_import.id}",
      account_id:       user.account_id,
      description:      "Invitation from #{provider} #{@client_import.id}",
      user_uuid:        user.uuid,
      user_id:          user.id,
      invited:          false,
      invitation_count: 0,
      sents:            0,
      opens:            0
    )
    contacts.each do |c|
      
      address_work  = nil
      city_work     = nil
      email_address = nil
      if emails = c[:emails]
        if email = emails.first
          email_address = email[:email]
          if addresses = c[:addresses]
            addresses.each do |address|
              if address[:name] == 'work'
                address_work = address[:address_1]
                city_work    = address[:city]
              end # end if work
            end # addresses.each
          end # end if addresses
        end
      else
        email_address = c[:email]
      end
        
      if email_address
        digiramp_user_id = nil
        if digiramp_user = User.get_by_email(email_address)
          digiramp_user_id = digiramp_user.id
        end
        client = Client.where(
          email:     email_address
        )
        .first_or_create(
          account_id:                 user.account_id,
          #user_uuid:                  user.uuid,
          name:                       c[:name],
          last_name:                  c[:last_name],
          #title:
          #photo:
          #telephone_home:
          #business_phone:
          #business_fax:
          #fax_home:
          #cell_phone:
          #company:
          #capacity:
          #address_home:
          address_work:            address_work,
          city_work:               city_work,
          #state_work:
          #zip_work:
          #country_work:
          email:                   email_address,
          #home_page:
          #department:
          #revision:
          #created_at:
          #updated_at:
          #assistant:
          #direct_phone:
          #direct_fax:
          #business_email:
          #show_alert:
          user_id:               user.id,
          #full_name:
          member_id:             digiramp_user_id,
          client_import_id:      @client_import.id

        )
        
        
        
        
        unless client_invitation = ClientInvitation.find_by( 
            account_id: current_user.account_id, 
            email: client.email
          )
          #client_invitation = ClientInvitation.create(
          #  account_id:   current_user.account_id, 
          #    client_id:  client.id,
          #    user_id:    current_user.id,
          #    uuid:       UUIDTools::UUID.timestamp_create().to_s,
          #    email:      client.email 
          #)
          
          client_group_client = ClientGroupsClients.create(
            client_group_id: @client_group.id,
            client_id:       client.id,
            user_uuid:       user.uuid
          )
          
          #client_invitation.send_one_with_avatar
          #invitations_send_to[invitations_send_to_index] = email 
          #invitations_send                      += 1
        end
        
       
      end # end if email_address

    end # end of contacts.each
    @client_group.invite_clients

    redirect_to user_user_gmail_invitation_path(user, @client_import)
  end

  def failure
    
  end

end