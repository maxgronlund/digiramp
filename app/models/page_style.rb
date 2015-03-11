class PageStyle < ActiveRecord::Base
  mount_uploader :backdrop_image,   ImageUploader
  
  validates_presence_of :title
  validates_presence_of :css_tag
  validates_presence_of :bgcolor
end
