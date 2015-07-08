class AddSuperAccountUsersToSupers < ActiveRecord::Migration
  def change
    add_column :users, :super_account_user_id, :integer
    add_index :users,  :super_account_user_id
    
    User.supers.each do |user|
      account_user      = AccountUser.create(user_id: user.id, account_id: User.system_user.account.id)
      account_user.grand_all_permissions
      user.super_account_user_id = account_user.id
      user.save!
    end
    
  end
end
