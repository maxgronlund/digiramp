class VideoBlog < ActiveRecord::Base
  has_many :videos
  #attr_accessible :title, :body
  validates :title, uniqueness: true

  def self.features; VideoBlog.where(title: 'features').first_or_create(title: 'features') end
end
