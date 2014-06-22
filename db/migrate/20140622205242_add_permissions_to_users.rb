class AddPermissionsToUsers < ActiveRecord::Migration
  def change
    add_column :account_users, :create_oppertunity, :boolean, derault: false
    add_column :account_users,   :read_oppertunity, :boolean, derault: false
    add_column :account_users, :update_oppertunity, :boolean, derault: false
    add_column :account_users, :delete_oppertunity, :boolean, derault: false
    
    add_column :accounts, :create_oppertunities, :boolean, derault: false
    add_column :accounts,   :read_oppertunities, :boolean, derault: false


  end
end
