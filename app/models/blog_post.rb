class BlogPost < ActiveRecord::Base
  belongs_to :blog
  has_many :comments, as: :commentable
  #attr_accessible :author, :body, :crop_params, :image, :image_title, :title, :blog_id, :identifier, :position, :link, :teaser, :layout
  validates_presence_of :title
  serialize :crop_params, Hash
  mount_uploader :image, ArtworkUploader
  include ImageCrop
  LAYOUTS = %w[layout_6_6  layout_4_8 layout_3_9 layout_12]
end
