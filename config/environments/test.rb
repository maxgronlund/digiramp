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
  config.consider_all_requests_local       = true
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

ENV["MAIL_USERNAME"]    = 'info@digiramp.org'
ENV["MAIL_PASSWORD"]    = 'IS5pleyu'


ENV["S3_KEY_ID"]        = 'AKIAJN4UDAY5IF3CRYDA'
ENV["S3_ACCESS_KEY"]    = 'UDH4rSx4N6A267q/Tii+K+9APoElnIQzwdlqo530'
ENV["AWS_S3_BUCKET"]    = 'digiramp-widget'

ENV['TWITTER_KEY']      = 'sxnwvjajuSgGiWWVlWMRXj6Qq'
ENV['TWITTER_SECRET']   = 'HVZQ8tlkDGTeOvaZnFjK4vAwmHPyfHtzDg6tbu98gslj6moCh9'

ENV['LINKEDIN_KEY']      = '77geot159kgi5l'
ENV['LINKEDIN_SECRET']   = 'VztOr48kHMunUq1L'

ENV['GPLUS_KEY']         = '49205251565-g2eq19fs28jcuotor86o9ls075nnovnk.apps.googleusercontent.com'
ENV['GPLUS_SECRET']      = 'Ox9KrfvCX9FCrTEyPBb6oQ94'
