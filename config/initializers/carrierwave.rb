ENV["S3_KEY_ID"]     = AMAZON_CONFIG['s3_key_id']
ENV["S3_ACCESS_KEY"] = AMAZON_CONFIG['s3_access_key']
ENV["AWS_S3_BUCKET"] = AMAZON_CONFIG['aws_s3_bucket']





CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id:      ENV["S3_KEY_ID"] , 
    aws_secret_access_key:  ENV["S3_ACCESS_KEY"],
    :region => 'us-west-1'
  }
  config.fog_directory    = ENV["AWS_S3_BUCKET"]
end


  
