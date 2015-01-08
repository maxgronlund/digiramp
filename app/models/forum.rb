class Forum < ActiveRecord::Base
  belongs_to :user
  has_many :forum_posts, dependent: :destroy
  
  
  scope :public_access,     -> { where(public_forum: true)}
  
  
  
  
end
