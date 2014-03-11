class RemoveAdministratorFromAccounts < ActiveRecord::Migration
  def change
    
    remove_column :accounts, :administrator_id
  end
end
