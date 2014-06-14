class AddAdministratorToUser < ActiveRecord::Migration
  def change
    add_column :users, :administrator, :boolean, default: false
    add_column :accounts, :administrator_id, :integer, default: 0
    
    add_index :accounts, :administrator_id
    
    Account.all.each do |account|
      account.administrator_id = account.user_id
      account.save!
    end
  end
end
