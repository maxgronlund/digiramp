set :stage, :production
set :branch, 'master'

# This is used in the Nginx VirtualHost to specify which domains
# the app should appear on. If you don't yet have DNS setup, you'll
# need to create entries in your local Hosts file for testing.
set :server_name, 'www.digiramp.com digiramp.com'

# used in case we're deploying multiple versions of the same
# app side by side. Also provides quick sanity checks when looking
# at filepaths
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"

server '45.32.91.107', user: 'deploy', roles: %w[web app db], primary: true

set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/#{fetch(:full_app_name)}"

# dont try and infer something as important as environment from
# stage name.
set :rails_env, :production

# number of @blog workers, this will be reflected in
# the @blog.rb and the monit configs
set :@blog_worker_count, 5

# whether we're using ssl or not, used for building nginx
# config file
set :enable_ssl, false

set :ssh_options, forward_agent: true
