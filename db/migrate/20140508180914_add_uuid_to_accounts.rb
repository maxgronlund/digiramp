class AddUuidToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :uuid, :string, default: ''
    
    Account.all.each do |account|
      account.uuid = UUIDTools::UUID.random_create().to_s
      account.save!
    end
    
    
  end
end
