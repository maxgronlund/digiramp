# obsolete class should be removed

class Video < ActiveRecord::Base
  #belongs_to :song
  belongs_to :video_blog
  
  ##attr_accessible :body, :mp4_video, :ogv_video, :thumb, :title,:video_width_in_pixels,:video_height_in_pixels
  #mount_uploader :thumb, ThumbUploader
  ##mount_uploader :mp4_video, Mp4Uploader
  ##mount_uploader :ogv_video, OgvUploader
  #mount_uploader :mp4_360_p, Mp4Uploader
  #mount_uploader :mp4_720_p, Mp4Uploader
  #mount_uploader :webm_360_p, WebmUploader
  #mount_uploader :webm_720_p, WebmUploader
  
  #has_many :activity_events, as: :activity_eventable
  
  #serialize :uploads,    Hash
  #serialize :mp4_video,  Hash
  #serialize :webm_video, Hash
  #has_many :comments,        as: :commentable
  #has_many :invites,         as: :inviteable
  #has_many :playlist_items,  as: :playlist_itemable
end


