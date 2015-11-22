class AddHasInvitedFriendsToUsers < ActiveRecord::Migration
  def change
    add_column :user_configurations, :has_invited_friends, :boolean, default: false
    User.find_each do |user|
      user.set_has_invited_friends
    end
  end
end
