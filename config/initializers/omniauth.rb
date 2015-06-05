#FACEBOOK_CONFIG = YAML.load_file("#{::Rails.root}/config/facebook.yml")[::Rails.env]
#FACEBOOL_APP_ID = FACEBOOK_CONFIG['app_id']
#FACEBOOL_SECRET = FACEBOOK_CONFIG['secret_key']

if Rails.env.test?
  Rails.application.secrets.facebook_app_id       = ENV["FACEBOOK_API_KEY_ID"] 
  Rails.application.secrets.facebook_secret_key   = ENV["FACEBOOK_SECRET_KEY"]
  Rails.application.secrets.twitter_app_id        = ENV["TWITTER_API_KEY_ID"] 
  Rails.application.secrets.twitter_secret_key    = ENV["TWITTER_SECRET_KEY"]
  Rails.application.secrets.linkedin_app_id       = ENV["LINKEDIN_API_KEY_ID"] 
  Rails.application.secrets.linkedin_secret_key   = ENV["LINKEDIN_SECRET_KEY"]
  Rails.application.secrets.gplus_app_id          = ENV["GPLUS_API_KEY_ID"] 
  Rails.application.secrets.gplus_secret_key      = ENV["GPLUS_SECRET_KEY"]
  Rails.application.secrets.stripe_client_id      = ENV["STRIPE_CLIENT_ID"]
  Rails.application.secrets.stripe_api_key        = ENV["STRIPE_API_KEY"]


end




Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless  Rails.env.production?
  
  # twitter
  provider :twitter,          Rails.application.secrets.twitter_app_id,     
                              Rails.application.secrets.twitter_secret_key
  
  # facebook                            
  provider :facebook,         Rails.application.secrets.facebook_app_id,    
                              Rails.application.secrets.facebook_secret_key, 
                              scope: "email, publish_actions, user_actions.music"
  # linkedin                            
  provider :linkedin,         Rails.application.secrets.linkedin_app_id,    
                              Rails.application.secrets.linkedin_secret_key, 
                              scope: 'r_basicprofile r_emailaddress w_share rw_company_admin', :fields => ["id", "email-address", "first-name", "last-name", "headline", "industry", "picture-url", "public-profile-url", "location", "connections"]
  # google+                            
  provider :gplus,            Rails.application.secrets.gplus_app_id,       
                              Rails.application.secrets.gplus_secret_key,    
                              scope: 'userinfo.email, userinfo.profile'
  # stripe                            
  provider :stripe_connect,   Rails.application.secrets.stripe_client_id,   
                              Rails.application.secrets.stripe_api_key,      
                              scope: 'read_write', stripe_landing: 'register'
end



  #provider :linkedin, Rails.application.secrets.linkedin_app_id, Rails.application.secrets.linkedin_secret_key