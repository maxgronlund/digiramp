#AMAZON_CONFIG = YAML.load_file("#{::Rails.root}/config/amazon.yml")[::Rails.env]
#ENV["S3_KEY_ID"]     = AMAZON_CONFIG['s3_key_id']
#ENV["S3_ACCESS_KEY"] = AMAZON_CONFIG['s3_access_key']
#ENV["AWS_S3_BUCKET"] = AMAZON_CONFIG['aws_s3_bucket']

#Aws.config[:credentials] = Aws::Credentials.new(CONFIG[:aws_key], CONFIG[:aws_secret])
#Aws.config[:region] = 'us-east-1'


#Rails.application.secrets.s3_key_id, # ENV["S3_KEY_ID"] , 
#Rails.application.secrets.s3_access_key, # 3ENV["S3_ACCESS_KEY"],
#Rails.application.secrets.aws_s3_region
#
#Rails.application.secrets.aws_s3_bucket  #ENV["AWS_S3_BUCKET"]


#ENV['AWS_ACCESS_KEY_ID']        = Rails.application.secrets.s3_key_id
#ENV['AWS_SECRET_ACCESS_KEY']    = Rails.application.secrets.s3_access_key

if Rails.env.test?
  Rails.application.secrets.aws_s3_region     = ENV['AWS_S3_REGION']
  Rails.application.secrets.s3_key_id         = ENV['S3_KEY_ID']
  Rails.application.secrets.s3_access_key     = ENV['S3_ACCESS_KEY']
end

Aws.config.update({
  region: Rails.application.secrets.aws_s3_region,
  credentials: Aws::Credentials.new(Rails.application.secrets.s3_key_id, Rails.application.secrets.s3_access_key),
})





#endpoint = sns.create_platform_endpoint(
#    platform_application_arn:'arn:aws:sns:us-east-1:arn:aws:sns:us-east-1:656201664836:my_topic:app/APNS_SANDBOX/Neighborly-iOS', 
#    token:'ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890', 
#    attributes: { "UserId" => "14" }
#)