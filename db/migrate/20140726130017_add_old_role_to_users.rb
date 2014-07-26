class AddOldRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :old_role, :string, default: ''
    
    User.all.each do |user|
      user.old_role = user.role
      user.save!
    end
  end
end
