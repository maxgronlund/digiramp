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

end

#TWITTER_CONFIG  = YAML.load_file("#{::Rails.root}/config/twitter.yml")[::Rails.env]
#TWITTER_KEY     = TWITTER_CONFIG['app_id']
#TWITTER_SECRET  = TWITTER_CONFIG['secret_key']
#
#LINKEDIN_CONFIG = YAML.load_file("#{::Rails.root}/config/linkedin.yml")[::Rails.env]
#LINKEDIN_KEY    = LINKEDIN_CONFIG['app_id']
#LINKEDIN_SECRET = LINKEDIN_CONFIG['secret_key']
#
#
#GPLUS_CONFIG    = YAML.load_file("#{::Rails.root}/config/gplus.yml")[::Rails.env]
#GPLUS_KEY       = GPLUS_CONFIG['app_id']
#GPLUS_SECRET    = GPLUS_CONFIG['secret_key']



Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter,  Rails.application.secrets.twitter_app_id,  Rails.application.secrets.twitter_secret_key
  provider :facebook, Rails.application.secrets.facebook_app_id, Rails.application.secrets.facebook_secret_key, scope: "email, publish_actions, user_actions.music"
  #provider :linkedin, Rails.application.secrets.linkedin_app_id, Rails.application.secrets.linkedin_secret_key
  provider :linkedin,  Rails.application.secrets.linkedin_app_id, Rails.application.secrets.linkedin_secret_key, :scope => 'r_basicprofile r_emailaddress w_share rw_company_admin', :fields => ["id", "email-address", "first-name", "last-name", "headline", "industry", "picture-url", "public-profile-url", "location", "connections"]
  provider :gplus,    Rails.application.secrets.gplus_app_id,    Rails.application.secrets.gplus_secret_key, scope: 'userinfo.email, userinfo.profile'
end