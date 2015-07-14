class GiveInitialLikes < ActiveRecord::Migration
  def change
    add_column :users, :user_likes, :integer, default: 0
    add_column :users, :likings, :integer, default: 0
    
    User.find_each do |user|
      user.update(likings: user.likes.count)
    end
  end
end
