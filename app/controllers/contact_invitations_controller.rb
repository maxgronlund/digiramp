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
  
   # linked to from email
  def decline_all_from_digiramp
    if client_invitation = ClientInvitation.where(uuid: params[:contact_invitation_id]).first
      ap client_invitation
    end
  end
  
  
  
  # logged in users can accept the invitation 
  # if the invitation is ment for them
  def accept_connection
    
    begin
      client_invitation = ClientInvitation.where(uuid: params[:contact_invitation_id]).first
      @inviter          = User.cached_find(client_invitation.user_id)
      
      #xxxxxxxxxxxxxxxx not right xxxxxxxxxxxxxxxxxxxxxxx
      connect_with_user( current_user, @inviter )
    rescue
      @message = 'Unable to create connection'
    end
    @message = "You are connected with #{@inviter.user_name}"
  end
  
  
  # logged in user declines the invitation
  # if the invitation is ment for them
  def decline_connection
    begin
      client_invitation     = ClientInvitation.where(uuid: params[:contact_invitation_id]).first
      @inviter              = User.cached_find(client_invitation.user_id)
      #xxxxxxxxxxxxxxxx not right xxxxxxxxxxxxxxxxxxxxxxx
      connection            = connect_with_user( current_user, @inviter )
      connection.dismissed  = true
      connection.save!
    rescue
      @error = 'Error'
    end
    @message = "You have declined to connect with #{@inviter.user_name}"
    
  end
  
  
  
  
  # filling in the form and accepting the connection
  def signup
    ap params
    if PasswordValidator.validate( params[:client][:password], params[:client][:password_confirmation])
      message = sign_up_with_valid_password( params )
      if message == 'Success'
        redirect_to user_path( @user )
      else
        redirect_to contact_invitation_accept_invitation_path(contact_invitation_id: params[:contact_invitation_id], message: message)
      end
    else
      ap '=================== bad password ============================'

      redirect_to contact_invitation_accept_invitation_path(contact_invitation_id: params[:contact_invitation_id], error_message: 'Password error. Please retype')
    end
  end
  
private

  def validate_invitation( client_invitation )
    
    if @client = client_invitation.client
      
      #login_status = user_is_logged_in ( @client )
      #return login_status unless login_status == 'Not logged in'
      
      if user_is_signed_up( client_invitation )
        
        @inviter = @client.user
        return 'Invitation is used: It seems like this invitaion has already been used'
      
      else
        if @inviter = @client.user
          return user_is_logged_in( @client )
        else
          return 'Error: Inviter is deleted'
        end
      end
    else
      'Error: Client is deleted'
    end

  end
  
  def user_is_signed_up( client_invitation )
    begin
     return true if User.where(email: client_invitation.client.email).first 
   rescue
   end
   false
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
        return "Logged in as other: Hi #{current_user.user_name} It seems like you already have an account" 
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
    
    if email = EmailValidator.saintize( params[:client][:email])
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
    # create user
    @user = User.new(   user_name:              client.full_name,
                        old_role:               'Customer',
                        provider:               'DigiRAMP',
                        private_profile:        false,
                        user_name:              client.full_name,
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
      #ap @user
      # create account
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
      
      connect_with_user( client.user, @user )
      return 'Success'
    end
    return 'Error: no user created'
    
  end
  
  def connect_with_user user_a, user_b
    
    unless connection = Connection.connected( user_a, user_b)
      # create connection on behaf of the invitor
      connection = Connection.create( user_id: user_a.id,
                                      connection_id: user_b.id,
                                      approved: true,
                                      dismissed: false,
                                      message: "" )

    end
    connection
  end
  


  
  def unsubscribe
    
  end
end
