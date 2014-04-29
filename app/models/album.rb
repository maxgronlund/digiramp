class Album < ActiveRecord::Base
  belongs_to :account
  has_many :recordings
  has_many :catalog_items, dependent: :destroy
  #has_many :activity_events, as: :activity_eventable
  #accepts_nested_attributes_for :recordings, :allow_destroy => true
  #mount_uploader :poster, PosterUploader
  #include ImageCrop
  
  
end
