class FollowerEvent < ActiveRecord::Base
  belongs_to :user
  
  has_many :follower_event_users, dependent: :destroy
  
  after_create :notify_followers
  

  def notify_followers

    self.user.followers.each do |follower|
      ap FollowerEventUser.create(follower_event_id: self.id, user_id: follower.id) 
    end
  end
  
  
end
