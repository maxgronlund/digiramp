PAYPAL_CONFIG = YAML.load_file("#{::Rails.root}/config/paypal.yml")[::Rails.env]
ENV["PAYPAL_HOST"]      = PAYPAL_CONFIG['paypal_host']
ENV["APP_HOST"]         = PAYPAL_CONFIG['app_host']
