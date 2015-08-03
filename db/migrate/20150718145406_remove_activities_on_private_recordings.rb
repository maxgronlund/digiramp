class RemoveActivitiesOnPrivateRecordings < ActiveRecord::Migration
  def change
    count = 0
    FollowerEvent.where(  postable_type: "Recording").each do |follower_even|
      if rec = Recording.cached_find(follower_even.postable_id )
        unless rec.privacy == 'Anyone'
          follower_even.destroy
          count += 1
        end
      end
    end
    # '================================'
    # count
  end
end
