



if Rails.env.test?
  Rails.application.secrets.stripe_api_key           = ENV["STRIPE_API_KEY"] 
  Rails.application.secrets.stripe_publishable_key   = ENV["STRIPE_PUBLISHABLE_KEY"]
end




Rails.configuration.stripe = {
  publishable_key: Rails.application.secrets.stripe_publishable_key,
  secret_key: Rails.application.secrets.stripe_api_key
}


Stripe.api_key = Rails.application.secrets.stripe_api_key

