Digiramp::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static asset server for tests with Cache-Control for performance.
  config.serve_static_files  = true
  config.static_cache_control = "public, max-age=3600"

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr
end



Rails.application.secrets.secret_key_base = 'aa288b794d1bcc3b4cbeb7945a63467da5ab2fc95a624b9c4848ad731e494b0338c144b7c35f6c593fe29d2ae3706cf7c99cb5f6cd6893a39bcc6b9eb2c86672'
Rails.application.secrets.secret_token    = '6613549ba36cfe5dcd4635cf6d648ea97d7c886cfe2276fd2ee305f29294f33b66dac74b741c3373c8bcc48d89026bf6ec6435fec2a5bfcfa5a1531b4a850fc6'



   