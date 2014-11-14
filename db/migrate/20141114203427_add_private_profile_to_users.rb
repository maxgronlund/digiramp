class AddPrivateProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :private_profile, :boolean, default: false
  end
end
