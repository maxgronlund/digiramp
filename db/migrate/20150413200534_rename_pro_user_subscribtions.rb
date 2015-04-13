class RenameProUserSubscribtions < ActiveRecord::Migration
  def up
    rename_table :pro_user_subscribtions, :subscriptions
    add_column :subscriptions, :account_type, :string
  end
  
  def down
    remove_column :subscriptions, :account_type
    rename_table :subscriptions, :pro_user_subscribtions
    
  end
end
