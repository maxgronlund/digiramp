class AddUniqFollowersCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uniq_followers_count, :string
    
    User.find_each do |user|
      user.uniq_followers_count = user.followers.count.to_uniq
      user.save
    end
  end
end
