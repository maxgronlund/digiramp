class AddLikedUsersCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :liked_users_count, :integer, default: 0
    
    User.find_each do |user|
      user.update_user_likes
    end
  end
end
