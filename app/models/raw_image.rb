class RawImage < ActiveRecord::Base
  mount_uploader :image,   ImageUploader
  validates_presence_of :title
  validates_presence_of :identifier
  validates_presence_of :image
end
