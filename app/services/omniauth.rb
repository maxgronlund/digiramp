class Omniauth
  
  def initialize
  end
  # atttaching an provider to an existing user'
  def self.attach_provider env, user
    
    if new_provider = AuthorizationProvider.where(user_id: user.id, provider: env['omniauth.auth']["provider"]).present?
      return nil
    else  

      credentials =  env['omniauth.auth']["credentials"]

      
      


      return AuthorizationProvider.create! do |provider|
                        provider.provider           = env['omniauth.auth']["provider"]
                        provider.uid                = env['omniauth.auth']["uid"]
                        provider.oauth_token        = credentials['token']
                        provider.oauth_secret       = credentials['secret']
                        provider.oauth_expires_at   = credentials["expires_at"]
                        provider.oauth_expires      = credentials["expires"]
                        provider.user_id            = user.id
                        provider.info               = env['omniauth.auth']["info"]
                        #provider.profile_name       
                        
      end
    end

  end
  
  # authorize or create an new account
  def self.authorize_with_omniauth env
    #authorization_provider = AuthorizationProvider.where( env.slice("provider", "uid")).first
    authorization_provider = AuthorizationProvider.where(provider: env.provider, uid: env.uid).first
    if authorization_provider
      return {user: authorization_provider.user}
    else
      user = create_from_omniauth(env)
      return { user: user[:user], message: user[:message]}
    end
    
  end

private

  def self.create_from_omniauth(env)
    ap env
    #raise env.to_yaml
    # create a user
    user = create_user( env )

    if user[:user]                
      if create_account_for( user[:user], env ) 
        update_user( user[:user], env)
        credentials =  env["credentials"]
        ap credentials
        AuthorizationProvider.create! do |provider|
               provider.provider            = env["provider"]
               provider.uid                 = env["uid"]
               provider.oauth_token        = credentials['token']
               provider.oauth_expires_at   = credentials["expires_at"]
               provider.oauth_expires      = credentials["expires"]
               provider.user_id             = user[:user].id
      
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
      if email = info[:email]
        email_missing = false
        user = User.where(email: email).first
      end
    end
    
    unless user
      user = User.create(  name:           env["info"]["nickname"], 
                           password:       UUIDTools::UUID.timestamp_create().to_s, 
                           social_avatar:  env[:info][:image],
                           email:          email,
                           email_missing:  email_missing,
                           user_name:      env[:info][:name])
    end                          
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
      ap info
      if info[:name]
        # create the account
        account = Account.create( title: info[:name], 
                                  account_type: Account::ACCOUNT_TYPES[0], 
                                  contact_email: info[:email], 
                                  user_id: user.id)
        # create the account user
        ap account
        account_user = AccountUser.create(   account_id: account.id, 
                                             user_id: user.id, 
                                             role: AccountUser::ROLES[0]
                                          )
        # grand some permissions
        account_user.grand_basic_permissions                  
        user.name       = info["name"] + '_' + ( User.last.id + 1 ).to_s if user.name.to_s == ''
        user.user_name  = user.name if user.user_name.to_s == ''
        user.account_id = account.id
        user.save!
        
        user.create_activity(  :created, 
                           owner: user,
                       recipient: user,
                  recipient_type: user.class.name,
                      account_id: user.account_id) 
        
        
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