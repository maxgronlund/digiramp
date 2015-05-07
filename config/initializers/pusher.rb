require 'pusher'

if Rails.env.test?
  Rails.application.secrets.pusher_app_id   = ENV["PUSHER_API_ID"] 
  Rails.application.secrets.pusher_key      = ENV["PUSHER_KEY"]
  Rails.application.secrets.pusher_secret   = ENV["PUSHER_SECRET"] 
end

Pusher.app_id   = Rails.application.secrets.pusher_app_id
Pusher.key      = Rails.application.secrets.pusher_key
Pusher.secret   = Rails.application.secrets.pusher_secret