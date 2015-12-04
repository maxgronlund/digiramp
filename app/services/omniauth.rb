class Omniauth
  
  def initialize
  end
  # atttaching an provider to an existing user'
  def self.attach_provider env, user
    return nil unless omniauth_auth = env['omniauth.auth']
    if new_provider = AuthorizationProvider.where(user_id: user.id, provider: omniauth_auth["provider"]).present?
      return nil
    else  

      credentials =  omniauth_auth["credentials"]


      new_provider = AuthorizationProvider.create! do |provider|
                        provider.provider           = omniauth_auth["provider"]
                        provider.uid                = omniauth_auth["uid"]
                        provider.oauth_token        = credentials['token']
                        provider.oauth_secret       = credentials['secret']
                        provider.oauth_expires_at   = credentials["expires_at"]
                        provider.oauth_expires      = credentials["expires"]
                        provider.user_id            = user.id
                        provider.info               = omniauth_auth["info"]
                        #provider.profile_name       
                        
      end
      # attach stripe to user
      if omniauth_auth["provider"] == 'stripe_connect'
        auth_hash = env['omniauth.auth']
        user.stripe_id              = auth_hash['uid']
        user.stripe_access_key      = auth_hash['credentials']['token']
        user.stripe_publishable_key = auth_hash['info']['stripe_publishable_key']
        user.stripe_refresh_token   = auth_hash['credentials']['refresh_token']
        user.has_enabled_shop       = true
        user.update_shop
        user.save!
      end

      return new_provider
    end
  end
  
  # authorize or create an new account
  def self.authorize_with_omniauth env
    
    #  env
    
    
    #authorization_provider = AuthorizationProvider.where( env.slice("provider", "uid")).first
    authorization_provider = AuthorizationProvider.where(provider: env.provider, uid: env.uid).first
    if authorization_provider
      credentials     =  env["credentials"]
      authorization_provider.oauth_token         = credentials['token']
      authorization_provider.oauth_expires_at    = credentials["expires_at"]
      authorization_provider.oauth_expires       = credentials["expires"] 
      #authorization_provider.info                = env['omniauth.auth']["info"]
      authorization_provider.save! 
      #authorization_provider
      return {user: authorization_provider.user}
    else
      user = create_from_omniauth(env)
      return { user: user[:user], message: user[:message]}
    end
    
  end

private

  def self.create_from_omniauth(env)
    #env
    #raise env.to_yaml
    # create a user
    user = create_user( env )

    if user[:user]                
      if create_account_for( user[:user], env ) 
        update_user( user[:user], env)
        credentials     =  env["credentials"]
        
        AuthorizationProvider.create! do |provider|
               provider.provider            = env["provider"]
               provider.uid                 = env["uid"]
               provider.oauth_token         = credentials['token']
               provider.oauth_expires_at    = credentials["expires_at"]
               provider.oauth_expires       = credentials["expires"]
               provider.user_id             = user[:user].id
               provider.info                = env["info"]
      
        end

       
        
        return {user: user[:user], message: user[:message]}
      else
        user[:user].destroy!   
        return { user: nil, message: "Unable to create account"} 
      end
    end
    return {user: user[:user], message: user[:message]}
    
  end
  
  def self.create_user( env )

    email         = UUIDTools::UUID.timestamp_create().to_s
    email_missing = true
    case env[:provider]
    when 'linkedin', 'gplus', 'facebook'
      info = env[:info]
      if email        = info[:email]
        email_missing = false
        user = User.where(email: email).first
      end
    end
    
    unless user

      user = User.create(  name:                  env["info"]["nickname"], 
                           password:              UUIDTools::UUID.timestamp_create().to_s, 
                           social_avatar:         env[:info][:image],
                           email:                 email,
                           email_missing:         email_missing,
                           user_name:             env[:info][:name],
                           confirmation_sent_at:  Time.now - 1.hour,
                           confirmed_at:          Time.now)
                           
                         
                         
      DefaultAvararJob.perform_later user.id
    end
    #begin 
    #  finished("landing_page")
    #  finished("invitation_from_user")  
    #rescue => e
    #  ErrorNotification.post_object 'Omniauth#create_user', e
    #end                         
    return {user: user, message: "#{env["provider"].upcase} has created a DigiRAMP account for you"}
  end
  
  def self.create_account_for( user, auth)

    info = nil
    
    case auth[:provider]
    when 'linkedin', 'gplus'
      info = auth[:info]
    when 'facebook', 'twitter'
      info = get_info_from_extra auth
    else
      return false
    end
    
    if info
      
      if info[:name]
        # create the account
        account = Account.create( title: info[:name], 
                                  account_type: Account::ACCOUNT_TYPES[0], 
                                  contact_email: info[:email], 
                                  user_id: user.id,
                                  expiration_date: Date.current + 6.months)
        # create the account user
        account_user = AccountUser.create(   account_id: account.id, 
                                             user_id: user.id, 
                                             role: AccountUser::ROLES[0]
                                          )
        # grand some permissions
        account_user.grand_basic_permissions                  
        #user.name       = info["name"] + '_' + ( User.last.id + 1 ).to_s if user.name.to_s == ''
        user.user_name  = user.get_full_name if user.user_name.to_s == ''
        user.account.id = account.id
        user.save!
        
        user.create_activity(  :created, 
                           owner: user,
                       recipient: user,
                  recipient_type: user.class.name,
                      account_id: user.account.id) 
        
        
        return true
      end
    end
    false
  end
  
  def self.get_info_from_extra auth
    
    extra = auth[:extra]
    if extra
      raw_info                 = extra[:raw_info]
      raw_info[:email_missing] = true unless raw_info[:email]
      return raw_info
    end
    nil
  end

  def self.update_user( user, env)
    info = env[:info]
    if info
      user.image    = info[:image]        if user.image.to_s == ''
      user.profile  = info[:description]  if user.profile.to_s == ''
      user.save!
    end
  end

  
end