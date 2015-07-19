class FindUsersWithTwoAccounts < ActiveRecord::Migration
  def change
    count = 0
    User.find_each do |user|
      accounts = Account.where(user_id: user.id)
      if accounts.count > 1
        count += 1
        ap '----------------------------------------'
        ap "#{user.user_name} has two accounts:"
        accounts.each do |account|
          ap "#{account.id}   |  created: #{account.created_at}"
        end
      end
    end
    ap '========================================'
    ap " out of #{Account.count} accounts"
    ap "#{count} users with two accounts found"
    ap "last account is #{Account.last.id}"
    ap '________________________________________' 
  end
end
