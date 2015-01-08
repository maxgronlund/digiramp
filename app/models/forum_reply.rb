class ForumReply < ActiveRecord::Base
  belongs_to :user
  belongs_to :replyable, polymorphic: true
end
