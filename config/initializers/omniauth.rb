FACEBOOK_CONFIG = YAML.load_file("#{::Rails.root}/config/facebook.yml")[::Rails.env]
FACEBOOL_APP_ID = FACEBOOK_CONFIG['app_id']
FACEBOOL_SECRET = FACEBOOK_CONFIG['secret_key']







Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter,  ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  #provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], scope: "email, publish_actions, user_actions.music"
  provider :facebook, FACEBOOL_APP_ID, FACEBOOL_SECRET, scope: "email, publish_actions, user_actions.music"
  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
  provider :gplus,    ENV['GPLUS_KEY'], ENV['GPLUS_SECRET'], scope: 'userinfo.email, userinfo.profile'
end