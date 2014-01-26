class Artwork < ActiveRecord::Base
  belongs_to :song
  belongs_to :gallery
  #attr_accessible :title, :body, :gallery_id, :image, :link, :position
  serialize :crop_params, Hash
  mount_uploader :image, ArtworkUploader
  include ImageCrop
end
