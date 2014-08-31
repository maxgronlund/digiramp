class AddSocialAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :social_avatar, :string, default: ''
  end
end
