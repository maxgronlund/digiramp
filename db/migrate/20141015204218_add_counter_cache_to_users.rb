class AddCounterCacheToUsers < ActiveRecord::Migration
  def change
    add_column :users,      :followers_count, :integer, default: 0
    
    User.find_each do |user|
      user.followers_count = user.followers.count
      user.save!
    end
    
    Recording.find_each do |recording|
      recording.likes_count = recording.likes.count
      recording.save!
    end
    

  end
end
