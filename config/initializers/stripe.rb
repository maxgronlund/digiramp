



if Rails.env.test?
  Rails.application.secrets.stripe_api_key           = ENV["STRIPE_API_KEY"] 
  Rails.application.secrets.stripe_publishable_key   = ENV["STRIPE_PUBLISHABLE_KEY"]
  #Rails.application.secrets.digiramp_stripe_split    = ENV["DIGIRAMP_STRIPE_SPLIT"]
  #Rails.application.secrets.digiramp_stripe_fee      = ENV["DIGIRAMP_STRIPE_FEE"]
end




Rails.configuration.stripe = {
  publishable_key: Rails.application.secrets.stripe_publishable_key,
  secret_key: Rails.application.secrets.stripe_api_key
}


Stripe.api_key = Rails.application.secrets.stripe_api_key

