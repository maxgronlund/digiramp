class SanitizeAccounts < ActiveRecord::Migration
  def change
    sanitize_accounts_without_user
    ap "Account's total: #{Account.count}"
    count = 0
    User.find_each do |user|
      accounts = Account.where(user_id: user.id)
      if accounts.count > 1
        count += 1
        ap "User id: #{user.id}:#{user.user_name}"
        accounts.each do |account|
          ap "Account id: #{account.id}"
        end
        ap '--------------------------'
      end
    end
    ap "Users's with more than on account: #{count}"
  end
  
  def sanitize_accounts_without_user
    ap "Account's total: #{Account.count}"
    count = 0
    Account.find_each do |account|
      if account.user.nil?
        count += 1
        account.destroy
      end
    end
    ap "Accounts's deleted: #{count}"
  end
end
