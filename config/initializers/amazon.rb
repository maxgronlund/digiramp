AMAZON_CONFIG = YAML.load_file("#{::Rails.root}/config/amazon.yml")[::Rails.env]
ENV["S3_KEY_ID"]     = AMAZON_CONFIG['s3_key_id']
ENV["S3_ACCESS_KEY"] = AMAZON_CONFIG['s3_access_key']
ENV["AWS_S3_BUCKET"] = AMAZON_CONFIG['aws_s3_bucket']


