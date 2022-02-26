source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
#gem 'rails', '4.2.6'
gem 'rails', '4.2.8'

# Use postgres as the database for Active Record
gem 'pg', '~> 0.20.0'


# Use SCSS for stylesheets
#gem 'sass-rails', '~> 4.0.3'
#gem 'bootstrap-sass', '~> 3.3.1'
#gem 'sass-rails', '~> 5.0.0.beta1'
gem 'sass-rails', '~> 5.0'
gem 'font-awesome-sass'

# Use compass for mixin stylesheets
#gem 'compass-rails'
gem 'compass', '~> 1.0.3'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
#gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'turboboost'

# Angular is used for the Player
#gem 'angularjs-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# DigiRAMP
gem "slim-rails"
gem 'countries'
gem 'country_select'
gem 'simple_form'
#gem 'backbone-on-rails'
gem 'kaminari'
gem 'kaminari-bootstrap', '~> 3.0.1'
#gem 'bootstrap-wysihtml5-rails'
#gem 'bootsy'
gem 'carrierwave'
gem 'mini_magick'
#gem 'sidekiq'
gem 'sidekiq', github: 'mperham/sidekiq'
gem 'responders', '~> 2.0'
gem 'whenever', require: false
#gem 'vanity', :git => 'git@github.com:assaf/vanity', :branch => 'master'
#gem 'split', :require => 'split/dashboard'

# not in use
#gem 'celluloid'
#gem 'mechanize'
gem 'watir', '~> 5.0.0'
gem 'watir-webdriver', '~> 0.6.10'
#gem 'selenium-webdriver', '~> 2.42.0'
#gem 'nokogiri', '~> 1.6.3.1'
gem 'nokogiri', '~> 1.13.3'
gem 'headless'
#gem 'linguistics'
gem 'levenshtein'
#gem 'chosen-rails'
#gem 'soundmanager-rails'
#gem 'soundmanager-rails', github: 'glaszig/soundmanager-rails'
#

#gem 'mailcheckjs-rails'

# for direct upload to s3
gem 'fog'


# autorization
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-linkedin'
gem "omniauth-gplus"
gem 'omniauth-stripe-connect', '>= 2.4.0'

# API's
# facebook
#gem "koala", "~> 1.11.0rc"
gem "koala", "~> 2.0"

# twitter
gem 'twitter'

# auto complete fields
#gem 'bootstrap_tokenfield_rails'
gem 'chosen-rails'


#gem 'bootstrap-editable-rails'
gem 'jQuery-Validation-Engine-rails'
gem 'sinatra', require: false

gem 'momentjs-rails', '>= 2.8.1'
gem 'bootstrap3-datetimepicker-rails', '~> 3.1.3'


# statistics
gem "chartkick"
gem 'groupdate'
gem 'public_activity'

#gem "nested_form" << use cocoon instead
#gem 'private_pub'
#gem "taglib-ruby"
#gem 'id3_tags'
#gem 'jquery-fileupload-rails'
gem 'icheck-rails', git: 'git://github.com/maxgronlund/icheck-rails.git'

# url validation
gem 'validates_formatting_of'


#=====================================
# Marilyn
gem 'dalli'
#gem 'transloadit-rails'
#gem 'texticle', require: 'texticle/rails'
gem 'pg_search'
gem 'transloadit-rails'
gem 'uuidtools'

gem "rails-erd"
gem 'gravatarify', '~> 3.0.0'
gem 'pusher'
gem "gritter", "1.1.0"
# gem "airbrake"
# gem "opbeat"
gem "cocoon"
gem 'rubyzip'
#gem 'bootstrap-validator-rails', '~> 0.5.3'

# pdf generator
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

# maintaince
gem 'traceroute'

gem 'friendly_id', '~> 5.0.0'
gem 'yomu'
# for nice logging
gem "awesome_print"
gem 'mandrill-api', require: 'mandrill'
gem 'mandrill-rails'

gem 'high_voltage', '~> 2.4.0'

gem "omnicontacts"
gem 'slack-notifier'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.0'
end


group :test, :development do
  gem "rspec-rails"
  gem "factory_girl_rails", "~> 4.0"
  gem "capybara"
  gem "guard-rspec"
  gem "rb-fsevent"
  # cucumber
  gem "minitest"
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'rails_best_practices'
  gem 'brakeman', :require => false
  gem 'faker'
end

gem 'bcrypt-ruby'
gem 'unicorn'
gem 'thin'

# uniqify names to work with caminari
gem 'uuid_stamper', git: 'git://github.com/maxgronlund/uuid_stamper.git'
gem 'aws-sdk', '~> 1'
gem 'aws-sdk-resources', '~> 2'
gem 'uuid', '~> 2.3.7'
gem 'stripe', '~> 1.21.0'
gem 'stripe_event'
gem 'aasm'
gem 'paper_trail', '~> 4.0.0.rc1'
gem 'docverter'
gem "recaptcha", :require => "recaptcha/rails"

group :development do
  gem 'rb-readline'
  # Use Capistrano for deployment
  gem 'capistrano'
  gem 'capistrano-rbenv'
  # rails specific capistrano functions
  gem 'capistrano-rails'

  # integrate bundler with capistrano
  gem 'capistrano-bundler'

  gem 'capistrano-sidekiq'
  gem 'spring'
  gem 'byebug'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'deadweight'
  gem 'mechanize'
end