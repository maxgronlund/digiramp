class ContactInvitationsController < ApplicationController
  
  
  # linked to from email
  def accept_invitation 
    if @client_invitation = ClientInvitation.where(uuid: params[:contact_invitation_id]).first
      @message = validate_invitation( @client_invitation ) 
    else
      @message = 'Error: Invitation do not exists?'
    end
  end
  
   # linked to from email
  def decline_invitation

    if @client_invitation = ClientInvitation.where(uuid: params[:contact_invitation_id]).first

      @message = validate_invitation( @client_invitation ) 
    else
      @message = 'Error: Invitation do not exists?'
    end
  end
  
  # when the user confirm not knowing inviter
  def confirm_decline_of_invitation

    
    @client_invitation        = ClientInvitation.where(uuid: params[:contact_invitation_id]).first
    @client_invitation.status = 'Declined'
    @client_invitation.save
    
  end
  
   # linked to from email
  def decline_all_from_digiramp
    if client_invitation = ClientInvitation.where(uuid: params[:contact_invitation_id]).first

    end
  end
  
  
  
  # logged in users can accept the invitation 
  # if the invitation is ment for them
  def accept_connection
    
    if client_invitation = ClientInvitation.where(uuid: params[:contact_invitation_id]).first
      
      if @inviter       = User.cached_find(client_invitation.user_id)
        if connect_with_user( current_user, @inviter )
        else
           @message        = 'Unable to create connection'
        end
      else
        @message        = 'Unable to create connection'
      end
    else
      @message          = 'Unable to create connection'
    end
    @message            = "You are connected with #{@inviter.user_name}"
  end
  
  
  # logged in user declines the invitation
  # if the invitation is ment for them
  def decline_connection
    
    if client_invitation        = ClientInvitation.where(uuid: params[:contact_invitation_id]).first
      if @inviter               = User.where(id: client_invitation.user_id).first
        if connection           = connect_with_user( current_user, @inviter )
          connection.dismissed  = true
          connection.save!
        else
          @error = 'Error'
        end
      else
         @error = 'Error'
      end
    else
      @error = 'Error'
    end
    @message = "You have declined to connect with #{@inviter.user_name}"
  end
  
  
  
  
  # filling in the form and accepting the connection
  def signup

    if PasswordValidator.validate( params[:client][:password], params[:client][:password_confirmation])
      message = sign_up_with_valid_password( params )
      if message == 'Success'
        redirect_to user_path( @user )
      else
        redirect_to contact_invitation_accept_invitation_path(contact_invitation_id: params[:contact_invitation_id], message: message)
      end
    else
      
      redirect_to contact_invitation_accept_invitation_path(contact_invitation_id: params[:contact_invitation_id], error_message: 'Password error. Please retype')
    end
  end
  
private

  def validate_invitation( client_invitation )
    
    if @client = client_invitation.client
      
      if user_is_signed_up( client_invitation )

        if @inviter = client_invitation.user
          if connect_with_user(  @client.user, current_user  )
            return "You are now connected with #{client_invitation.user.user_name}"
          else
            return 'Error: Inviter not found'
          end
        else
           return 'Error: Inviter not found'
        end
      
      else
        if @inviter = client_invitation.user
          return user_is_logged_in( @client )
        else
          return 'Error: Inviter not found'
        end
      end
    else
      'Error: Client not found'
    end

  end
  
  def user_is_signed_up( client_invitation )
    User.where(email: client_invitation.client.email).first 
  end

  #def process_client client
  #  
  #  if message = user_is_logged_in( client )
  #    return message
  #  if @inviter = User.where( client.user_id).first
  #  else
  #    return 'Error: Inviter is no longer a member'
  #  end
  #end
  
  def user_is_logged_in client
    if current_user
      if current_user.email == client.email
        return 'Signed up with email: You are already signed up and signed in'
      else
        return "Logged in as other: Hi #{current_user.user_name} It seems like you are logged in with another email than this invitation was send to" 
      end
    end
    'Not logged in'
  end

  def sign_up_with_valid_password params
    
    if client_invitation = ClientInvitation.where(uuid: params[:contact_invitation_id]).first
      return sign_up_with_valid_invitation( params, client_invitation ) 
    end
    return 'Error: Invitation do not exists'
    
  end
  
  def sign_up_with_valid_invitation params, client_invitation
    
    if email = EmailSanitizer.saintize( params[:client][:email])
      return sign_up_with_valid_email( params, client_invitation, email )
    end
    return 'Error: Invalid email'
  end
  
  def sign_up_with_valid_email params, client_invitation, email
    if client = client_invitation.client
      return sign_up_with_valid_client( params, client_invitation, email, client )
    end
    return 'Error: Client do not exist'
  end
  
  def sign_up_with_valid_client params, client_invitation, email, client

    if @user = User.where(email: client.email).first
      return 'Error: User already signed up'
    else
      return sign_up_with_new_user( params, client_invitation, email, client )
    end 

  end
  
  def sign_up_with_new_user params, client_invitation, email, client
    
    if params[:client][:user_name].to_s == ''
      full_name = client.full_name
      full_name = User.create_uniq_user_name_from_email( email )  if full_name == ' '
    else
      full_name = params[:client][:user_name]
    end

    # create user
    @user = User.new(   user_name:              full_name,
                        old_role:               'Customer',
                        provider:               'DigiRAMP',
                        private_profile:        false,
                        first_name:             client.name,
                        last_name:              client.last_name,
                        profession:             client.capacity,
                        email:                  email,
                        password:               params[:client][:password],
                        link_to_homepage:       LinkValidator.validate( client.home_page),
                        messages_not_read:      0,
                        uniq_followers_count:   Uniqifyer.uniqify( 0 ),
                        uniq_completeness:      Uniqifyer.uniqify( 0 ),
                        uuid:                   UUIDTools::UUID.timestamp_create().to_s,
                        composer:               client.capacity == 'Composer',
                        invited:                true,
                        city:                   client.city_work,
                        country:                client.country_work
                      )
    

    if @user.save

      @account                        = User.create_a_new_account_for_the @user
      @account.title                  = client.company if client.company.to_s != ''
      @account.account_type           = 'Social'
      @account.contact_first_name     = @user.first_name
      @account.contact_last_name      = @user.last_name
      
      
      # update client
      #client.is_member = true
      client.member_id = @user.id
      client.save!
      
      @user.authenticate(@user.password)
      cookies[:auth_token]        = @user.auth_token
      cookies.permanent[:user_id] = @user.id
  
      @user.create_activity(  :signed_in, 
                         owner: @user,
                     recipient: @user,
                recipient_type: @user.class.name,
                    account_id: @user.account_id) 
      
      
      session[:show_profile_completeness] = false
      
      if client.user
        if connect_with_user( client.user, @user ) 
          return 'Success'
        else
          return 'Error: no user created'
        end
      end
    end
    return 'Error: no user created'
    
  end
  
  def connect_with_user user_a, user_b
    
    unless connection = Connection.connected( user_a, user_b)
      # create connection on behaf of the invitor
      if user_a && user_b
        connection = Connection.create( user_id: user_a.id,
                                        connection_id: user_b.id,
                                        approved: true,
                                        dismissed: false,
                                        message: "" )
                                        
                                        
                                      
        
        #sender    = User.cached_find(@user.id)
        
        
        @message = Message.create(recipient_id: user_a.id, sender_id: user_b.id, title: 'Invitation accepted', body: "Your invitation send to #{user_b.email} has been accepted")
        
        
        
        inviter   = User.cached_find(user_a.id)
        invited   = User.cached_find(user_b.id)
        channel = 'digiramp_radio_' + inviter.email
        Pusher.trigger(channel, 'digiramp_event', {"title" => 'Invitation accepted', 
                                              "message" => "#{invited.user_name} has accepted your invitation", 
                                              "time"    => '2000', 
                                              "sticky"  => 'false', 
                                              "image"   => 'notice'
                                              })
            
        
       
        @message.send_as_email 
      end

    end
    connection
  end
  


  
  def unsubscribe
    
  end
end
