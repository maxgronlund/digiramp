class Sanitize < ActiveRecord::Migration
  def change
    super_user = User.system_user
    FollowerEvent.where(postable_type: 'User').each do |followed_event|

      if user = User.cached_find(followed_event.postable_id)
      else
        ap "no user with: #{followed_event.postable_id}"
        followed_event.destroy
      end
    end
    
    FollowerEvent.where(postable_type: 'Recording').each do |followed_event|

      if recording = Recording.cached_find(followed_event.postable_id)
      elsif recording.user_id ==  super_user
        recording.remove_from_collections
      else 
        ap "no recording with: #{followed_event.postable_id}"
      end
    end
    
    FollowerEvent.where(postable_type: 'Relationship').each do |followed_event|

      if user = User.cached_find(followed_event.postable_id)
      else
        ap "the followede user is missing: #{followed_event.postable_id}"
      end
    end

  end
end
