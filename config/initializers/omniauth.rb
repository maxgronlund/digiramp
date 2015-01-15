Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter,  ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  #provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], scope: "email, publish_actions, user_actions.music"
  #provider :facebook, FACEBOOK_CONFIG['app_id'], FACEBOOK_CONFIG['secret_key'], scope: "email, publish_actions, user_actions.music"
  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
  provider :gplus,    ENV['GPLUS_KEY'], ENV['GPLUS_SECRET'], scope: 'userinfo.email, userinfo.profile'
end