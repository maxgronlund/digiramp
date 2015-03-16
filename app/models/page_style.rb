class PageStyle < ActiveRecord::Base
  mount_uploader :backdrop_image,   ImageUploader
  
  validates_presence_of :title
  validates_presence_of :css_tag
  validates_presence_of :bgcolor
  
  def self.deep_blue
    PageStyle.where(css_tag: 'deep_blue').first_or_create(css_tag: 'deep_blue', title: 'Deep blue')
  end
end
