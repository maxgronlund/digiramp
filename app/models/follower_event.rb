class FollowerEvent < ActiveRecord::Base
  belongs_to :user
  
  has_many :follower_event_users, dependent: :destroy
  
  after_create :notify_followers
  after_commit :flush_cache

  def notify_followers

    self.user.followers.each do |follower|
      FollowerEventUser.create(follower_event_id: self.id, user_id: follower.id) 
    end
    
    # also post it on my own dashboard
    FollowerEventUser.create(follower_event_id: self.id, user_id: self.user.id) 
  end
  
  def get_recording
    begin
      return Recording.cached_find(self.postable_id)
    rescue
      ap msg = "Recording not found #{self.postable_id}"
      Opbeat.capture_message(msg)
    end
  end
  
  # The user the followed user did something with
  def get_user_on_user
    User.cached_find(self.postable_id)
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end 
end
