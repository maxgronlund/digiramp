set :pty,  false
set :application, 'digiramp'
set :deploy_user, 'deploy'

#
# setup repo details
set :scm, :git
set :repo_url, 'git@github.com:maxgronlund/digiramp.git'
#set :sidekiq_pid, "#{current_path}/tmp/pids/sidekiq.pid"


# setup rvm.
set :rbenv_type, :system
set :rbenv_ruby, '2.1.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# how many old releases do we want to keep, not much
set :keep_releases, 5

# files we want symlinking to specific entries in shared
#set :linked_files, %w{config/database.yml config/application.yml config/sidekiq.yml}
set :linked_files, %w{config/database.yml config/application.yml config/facebook.yml config/twitter.yml config/linkedin.yml config/gplus.yml  config/transloadit.yml config/paypal.yml config/secrets.yml}

# dirs we want symlinking to shared
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

# what specs should be run before deployment is allowed to
# continue, see lib/capistrano/tasks/run_tests.cap
set :tests, []

# which config files should be copied by deploy:setup_config
# see documentation in lib/capistrano/tasks/setup_config.cap
# for details of operations
set(:config_files, %w(
  nginx.conf
  log_rotation
  monit
  unicorn.rb
  unicorn_init.sh
  sidekiq_init.sh
))

#set(:config_files, %w(
#  nginx.conf
#  application.yml
#  log_rotation
#  monit
#  unicorn.rb
#  unicorn_init.sh
#))

# which config files should be made executable after copying
# by deploy:setup_config
#set(:executable_config_files, %w(
#  unicorn_init.sh sidekiq_init.sh
#))
set(:executable_config_files, %w(
  unicorn_init.sh
))


# files which need to be symlinked to other parts of the
# filesystem. For example nginx virtualhosts, log rotation
# init scripts etc.
set(:symlinks, [
  {
    source: "nginx.conf",
    link: "/etc/nginx/sites-enabled/{{full_app_name}}"
  },
  {
    source: "unicorn_init.sh",
    link: "/etc/init.d/unicorn_{{full_app_name}}"
  },
  {
    source: "log_rotation",
   link: "/etc/logrotate.d/{{full_app_name}}"
  },
  {
    source: "monit",
    link: "/etc/monit/conf.d/{{full_app_name}}.conf"
  }
  #,
  #{
  #  source: "sidekiq_init.sh",
  #  link: "/etc/init.d/sidekiq_{{full_app_name}}"
  #}
])

# this:
# http://www.capistranorb.com/documentation/getting-started/flow/
# is worth reading for a quick overview of what tasks are called
# and when for `cap stage deploy`

namespace :deploy do
  # make sure we're deploying what we think we're deploying
  before :deploy, "deploy:check_revision"
  # only allow a deploy with passing tests to deployed
  #before :deploy, "deploy:run_tests"
  # compile assets locally then rsync
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'
  
  

  # remove the default nginx configuration as it will tend
  # to conflict with our configs.
  #before 'deploy:setup_config', 'nginx:remove_default_vhost'

  # reload nginx to it will pick up any modified vhosts from
  # setup_config
  #after 'deploy:setup_config', 'nginx:reload'

  # Restart monit so it will pick up any monit configurations
  # we've added
  after 'deploy:setup_config', 'monit:restart'

  # As of Capistrano 3.1, the `deploy:restart` task is not called
  # automatically.
  after 'deploy:publishing', 'deploy:restart'
  
  # copy images without uuid stamp
  after 'deploy:publishing', 'deploy:copy_images'
end


