class UsersWithManyAccounts < ActiveRecord::Migration
  def change
    multiple_account_users = 0
    User.find_each do |user|
      
      if accounts = Account.where(user_id: user.id)
        if accounts.count > 1
          ap '-----------------------------------'
          ap "#{user.account.id}: #{user.user_name}"
          
          accounts.each do |account|
            ap account.id
          end
          
          multiple_account_users += 1
        end
      end
    end
    
    ap "Users with multiple accounts: #{multiple_account_users}"
    ap '==================================='
  end
end
