FACEBOOK_CONFIG = YAML.load_file("#{::Rails.root}/config/facebook.yml")[::Rails.env]
FACEBOOL_APP_ID = FACEBOOK_CONFIG['app_id']
FACEBOOL_SECRET = FACEBOOK_CONFIG['secret_key']

TWITTER_CONFIG  = YAML.load_file("#{::Rails.root}/config/twitter.yml")[::Rails.env]
TWITTER_KEY     = TWITTER_CONFIG['app_id']
TWITTER_SECRET  = TWITTER_CONFIG['secret_key']

LINKEDIN_CONFIG = YAML.load_file("#{::Rails.root}/config/linkedin.yml")[::Rails.env]
LINKEDIN_KEY    = LINKEDIN_CONFIG['app_id']
LINKEDIN_SECRET = LINKEDIN_CONFIG['secret_key']


GPLUS_CONFIG    = YAML.load_file("#{::Rails.root}/config/gplus.yml")[::Rails.env]
GPLUS_KEY       = GPLUS_CONFIG['app_id']
GPLUS_SECRET    = GPLUS_CONFIG['secret_key']



Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter,  TWITTER_KEY, TWITTER_SECRET
  provider :facebook, FACEBOOL_APP_ID, FACEBOOL_SECRET, scope: "email, publish_actions, user_actions.music"
  provider :linkedin, LINKEDIN_KEY, LINKEDIN_SECRET
  #provider :linkedin, LINKEDIN_KEY, LINKEDIN_SECRET, :scope => 'r_fullprofile r_emailaddress r_network', :fields => ["id", "email-address", "first-name", "last-name", "headline", "industry", "picture-url", "public-profile-url", "location", "connections"]
  provider :gplus,    GPLUS_KEY, GPLUS_SECRET, scope: 'userinfo.email, userinfo.profile'
end