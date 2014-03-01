class UpdateUserIdForAccounts < ActiveRecord::Migration
  def change
    
    Account.all.each do |account|
      account.user_id = account.administrator_id if account.user_id.nil?
      account.save!
    end
  end
end
