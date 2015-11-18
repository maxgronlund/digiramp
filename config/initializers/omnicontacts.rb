#require "omnicontacts"
#
#Rails.application.middleware.use OmniContacts::Builder do
#  importer :gmail, Rails.application.secrets.gplus_app_id, Rails.application.secrets.gplus_secret_key, {:redirect_path => "/invites/gmail/contact_callback"}
#  importer :yahoo, "dj0yJmk9bklXUzJxd2lydzg4JmQ9WVdrOVUwNHhlWEZDTkhFbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD05MQ--", "ae57848df503898d81baa6f4e871ad72e899bffd", {:callback_path => '/invites/yahoo/contact_callback'} 
#  
#  #importer :yahoo, "consumer_id", "consumer_secret", {:callback_path => '/callback'}
#  #importer :linkedin, "consumer_id", "consumer_secret", {:redirect_path => "/oauth2callback", :state => '<long_unique_string_value>'}
#  #importer :hotmail, "client_id", "client_secret"
#  #importer :facebook, "client_id", "client_secret"
#end