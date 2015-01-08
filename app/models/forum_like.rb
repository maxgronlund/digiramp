class ForumLike < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum_post
end
