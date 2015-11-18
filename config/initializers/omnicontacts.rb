require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, Rails.application.secrets.gplus_app_id, Rails.application.secrets.gplus_secret_key, {:redirect_path => "/invites/gmail/contact_callback"}
  importer :yahoo, "dj0yJmk9TEVycmliSEo4YlhTJmQ9WVdrOWNHRnhWbkI1Tm1zbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD02ZQ--", "a3b0475b18a8864685f84192636e7cb9c3cad135", {:callback_path => '/invites/jahoo/contact_callback'} 
  
  #importer :yahoo, "consumer_id", "consumer_secret", {:callback_path => '/callback'}
  #importer :linkedin, "consumer_id", "consumer_secret", {:redirect_path => "/oauth2callback", :state => '<long_unique_string_value>'}
  #importer :hotmail, "client_id", "client_secret"
  #importer :facebook, "client_id", "client_secret"
end