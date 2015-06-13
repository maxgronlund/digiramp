ActionMailer::Base.smtp_settings = {
  address: Rails.application.secrets.email_provider_address,
  port: 587,
  domain: Rails.application.secrets.domain_name,
  enable_starttls_auto: true,
  user_name: Rails.application.secrets.email_provider_username,
  password: Rails.application.secrets.email_provider_password,
  authentication: "login"
  
}



ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default  charset: 'utf-8'



