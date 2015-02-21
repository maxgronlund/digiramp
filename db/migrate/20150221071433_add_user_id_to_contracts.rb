class AddUserIdToContracts < ActiveRecord::Migration
  def change
    
    add_column :contracts, :contract_type, :string
    add_column :contracts, :body, :text
    
    add_reference :contracts, :contractable, polymorphic: true, index: true
    
    add_column :contracts, :user_id, :integer
    add_column :contracts, :account_id, :integer
    
    add_index :contracts, :user_id
    add_index :contracts, :account_id
  end
end
