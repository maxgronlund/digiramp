class PageStyle < ActiveRecord::Base
  mount_uploader :backdrop_image,   ImageUploader
  
  validates_presence_of :title
  validates_presence_of :css_tag
  validates_presence_of :bgcolor
  
  def self.deep_blue
    PageStyle.where(css_tag: 'deep_blue').first_or_create(css_tag: 'deep_blue', title: 'Deep blue', bgcolor: '#000')
  end
  def self.plain_style
    PageStyle.where(css_tag: 'plain_style').first_or_create(css_tag: 'plain_style', title: 'Plain', bgcolor: '#ffffff')
  end
end
