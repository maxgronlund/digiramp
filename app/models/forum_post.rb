class ForumPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum
  
  has_many :replies, as: :replyable,   dependent: :destroy
end
