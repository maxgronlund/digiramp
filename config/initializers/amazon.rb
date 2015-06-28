
if Rails.env.test?
  Rails.application.secrets.s3_key_id       = ENV["S3_KEY_ID"] 
  Rails.application.secrets.s3_access_key   = ENV["S3_ACCESS_KEY"]
  Rails.application.secrets.aws_s3_region   = ENV["AWS_S3_REGION"]
  Rails.application.secrets.aws_s3_bucket   = ENV["AWS_S3_BUCKET"]
end

Aws.config.update({
  region: Rails.application.secrets.aws_s3_region,
  credentials: Aws::Credentials.new(Rails.application.secrets.s3_key_id, Rails.application.secrets.s3_access_key),
})


#
## this workd
#resp = s3.list_buckets
#ap resp.buckets.map(&:name)


# list the first two objects in a bucket
#resp = AWS_S3.list_objects(bucket: Rails.application.secrets.aws_s3_bucket, max_keys: 2)
#resp.contents.each do |object|
#  puts "#{object.key} => #{object.etag}"
#end