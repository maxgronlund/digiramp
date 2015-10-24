class UpdateLikesOnRecordings < ActiveRecord::Migration
  def change
    
    Recording.find_each do |recording|
      recording.update(uniq_likes_count: recording.likes.count.to_uniq )
    end
  end
end
