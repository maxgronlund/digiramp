#Split.configure do |config|
#  config.persistence = Split::Persistence::RedisAdapter.with_config(lookup_by: -> (context) { context.current_user_id })
#  # Equivalent
#  # config.persistence = Split::Persistence::RedisAdapter.with_config(lookup_by: :current_user_id)
#end

Split.configure do |config|
  config.persistence = :cookie
end

Split::Dashboard.use Rack::Auth::Basic do |username, password|
  username == 'ab-test' && password == 'better-digiramp-convertion-rate'
end