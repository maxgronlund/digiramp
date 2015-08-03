class FindUsersWithTwoAccounts < ActiveRecord::Migration
  def change
    count = 0
    User.find_each do |user|
      accounts = Account.where(user_id: user.id)
      if accounts.count > 1
        count += 1
        # '----------------------------------------'
        # "#{user.user_name} has two accounts:"
        accounts.each do |account|
          # "#{account.id}   |  created: #{account.created_at}"
        end
      end
    end
    # '========================================'
    # " out of #{Account.count} accounts"
    # "#{count} users with two accounts found"
    # "last account is #{Account.last.id}"
    # '________________________________________' 
  end
end
