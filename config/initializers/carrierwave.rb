
#if Rails.env.test?
#  Rails.application.secrets.s3_key_id       = ENV["S3_KEY_ID"] 
#  Rails.application.secrets.s3_access_key   = ENV["S3_ACCESS_KEY"]
#  Rails.application.secrets.aws_s3_region   = ENV["AWS_S3_REGION"]
#  Rails.application.secrets.aws_s3_bucket   = ENV["AWS_S3_BUCKET"]
#end

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id:      Rails.application.secrets.s3_key_id, # ENV["S3_KEY_ID"] , 
    aws_secret_access_key:  Rails.application.secrets.s3_access_key, # ENV["S3_ACCESS_KEY"],
    region:                 Rails.application.secrets.aws_s3_region
  }
  config.fog_directory    = Rails.application.secrets.aws_s3_bucket  #ENV["AWS_S3_BUCKET"]
end



module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end

  
