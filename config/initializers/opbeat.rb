require "opbeat"

Opbeat.configure do |config|
 config.organization_id = "db3a398ec4034b3b9f8e9d5ce0bd1ac3"
 config.app_id = "08ddd0a9f0"
 config.secret_token = "306e385b0cb8765801763d25cb472e8ba6b8097b"
 
 config.environments = %w[ production ]
 config.excluded_exceptions = ['ActionController::RoutingError', 'ActiveRecord::RecordNotFound']
end