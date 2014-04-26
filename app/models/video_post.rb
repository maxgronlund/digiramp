class VideoPost < ActiveRecord::Base
  mount_uploader :thumb, ThumbUploader
  serialize :transloadet
end
