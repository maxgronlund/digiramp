SENDGRID_CONFIG = YAML.load_file("#{::Rails.root}/config/sendgrid.yml")[::Rails.env]
SENDGRID_USERNAME    = SENDGRID_CONFIG['sendgrid_username']
SENDGRID_PASSWORD    = SENDGRID_CONFIG['sendgrid_password']
