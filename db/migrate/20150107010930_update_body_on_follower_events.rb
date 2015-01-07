class UpdateBodyOnFollowerEvents < ActiveRecord::Migration
  def change
    FollowerEvent.where(body: 'Recording').find_each do |follower_event|
      follower_event.body = 'Uploaded this recording'
      follower_event.save!
    end
  end
end
