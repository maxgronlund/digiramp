class AddPremissionKeyToAccountUsers < ActiveRecord::Migration
  def change
    add_column :account_users, :permission_key, :string, default: ''
    
    AccountUser.all.each do |account_user|
      account_user.permission_key =  UUIDTools::UUID.timestamp_create().to_s
      account_user.save!
    end
  end
end
