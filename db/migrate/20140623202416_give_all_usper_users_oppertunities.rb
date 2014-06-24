class GiveAllUsperUsersOppertunities < ActiveRecord::Migration
  def change
    
    change_column_default :account_users, :create_oppertunity, false
    change_column_default :account_users, :read_oppertunity, false
    change_column_default :account_users, :update_oppertunity, false
    change_column_default :account_users, :delete_oppertunity, false
    
    
    AccountUser.all.each do |account_user|
      if account_user.role == 'Super'
        account_user.create_oppertunity = true
        account_user.read_oppertunity   = true
        account_user.update_oppertunity = true
        account_user.delete_oppertunity = true
        account_user.save!

      end
    end
  end
end
