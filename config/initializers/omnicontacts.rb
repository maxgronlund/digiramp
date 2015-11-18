require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, Rails.application.secrets.gplus_app_id, Rails.application.secrets.gplus_secret_key, {:redirect_path => "/invites/gmail/contact_callback"}
  importer :yahoo, "dj0yJmk9VDZjdjBsSWVNSEc3JmQ9WVdrOVJrWmhjR2QzTkdFbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD1hZQ--", "72891f29535a555e573ca95cdd16c2a2a81a2076", {:callback_path => '/invites/yahoo/contact_callback'} 
  
  #importer :yahoo, "consumer_id", "consumer_secret", {:callback_path => '/callback'}
  #importer :linkedin, "consumer_id", "consumer_secret", {:redirect_path => "/oauth2callback", :state => '<long_unique_string_value>'}
  #importer :hotmail, "client_id", "client_secret"
  #importer :facebook, Rails.application.secrets.facebook_app_id, Rails.application.secrets.facebook_secret_key
end