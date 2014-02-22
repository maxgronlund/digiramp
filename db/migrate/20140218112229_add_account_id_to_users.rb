class AddAccountIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :account, index: true
    
    User.all.each do |user|
      
      user.account_id = user.current_account_id
      user.save!
    end
  end
end
