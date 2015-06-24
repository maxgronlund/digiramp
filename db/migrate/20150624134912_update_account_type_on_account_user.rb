class UpdateAccountTypeOnAccountUser < ActiveRecord::Migration
  def change
    
    User.find_each do |user|
      account = user.account
      user.account_type = account.account_type
      user.save(validate: false)
    end
  end
end
