source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.7'

# Use sqlite3 as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
#gem 'sass-rails', '~> 4.0.3'
#gem 'bootstrap-sass', '~> 3.3.1'
gem 'sass-rails', '~> 5.0.0.beta1'
gem 'font-awesome-sass'

# Use compass for mixin stylesheets
#gem 'compass-rails'
gem 'compass', '~> 1.0.0.alpha.21'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
#gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

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
gem 'sidekiq'
gem 'whenever', require: false

# not in use
#gem 'celluloid'
#gem 'mechanize'
gem 'watir', '~> 5.0.0'
gem 'watir-webdriver', '~> 0.6.10'
#gem 'selenium-webdriver', '~> 2.42.0'
gem 'nokogiri', '~> 1.6.3.1'
gem 'headless'
#gem 'linguistics'
gem 'levenshtein'
#gem 'chosen-rails', '0.12.0'
#gem 'soundmanager-rails'
#

#gem 'mailcheckjs-rails'

# for direct upload to s3
gem 'fog'


# autorization
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-linkedin'
gem "omniauth-gplus"

# API's
# facebook
gem "koala", "~> 1.11.0rc"
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
gem 'icheck-rails'


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
gem "airbrake"
gem "cocoon"
gem 'rubyzip'
#gem 'bootstrap-validator-rails', '~> 0.5.3'

# maintaince
gem 'traceroute'

# avoid ActionController::InvalidCrossOriginRequest
# gem 'rack-cors', :require => 'rack/cors'


gem 'friendly_id', '~> 5.0.0' 
#gem 'bootstrap-datepicker-rails'


# for extraction of text content
gem 'yomu'

# for nice logging
gem "awesome_print"

#gem 'jquery_file_download-rails'


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.0'
  
end

# For cucumber
#group :test do
#  gem 'cucumber-rails', :require => false
#  gem 'rspec-rails'
#  gem 'database_cleaner'
#  gem 'factory_girl'
#  gem 'selenium-webdriver'
#end


group :test, :development do
  gem "rspec-rails", '~> 3.1.0'
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
  gem "rb-fsevent"
  # cucumber
  gem "minitest"
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'selenium-webdriver'
end


gem 'bcrypt-ruby'


# Use unicorn as the app server
gem 'unicorn'

gem 'thin'

# uniqify names to work with caminari
gem 'uuid_stamper', '~> 0.0.3', git: 'git://github.com/maxgronlund/uuid_stamper.git'

#gem 'capistrano-sidekiq' , github: 'seuros/capistrano-sidekiq'
#gem 'capistrano-sidekiq'

gem 'aws-sdk', '~> 1.48.1'
gem 'uuid', '~> 2.3.7'

group :development do
  # Use Capistrano for deployment
  gem 'capistrano'
  
  gem 'capistrano-rbenv'
  
  # rails specific capistrano functions
  gem 'capistrano-rails'
  
  # integrate bundler with capistrano
  gem 'capistrano-bundler'
  
  #gem "capistrano-sidekiq"
  #gem 'capistrano-sidekiq'
  gem 'capistrano-sidekiq'
  
  # if you are using RVM
  #gem 'capistrano-rvm'
  
  #gem "sshkit", '~> 1.2'

  # Use debugger
  # gem 'debugger', group: [:development, :test]
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'byebug'  
  gem 'quiet_assets'
  
  gem 'better_errors'
  gem 'binding_of_caller'
end


