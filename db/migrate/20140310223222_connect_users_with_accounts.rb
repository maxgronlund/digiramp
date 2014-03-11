class ConnectUsersWithAccounts < ActiveRecord::Migration
  def change
    User.all.each do |user|
      if account = Account.where(user_id: user.id).first
        user.account_id = account.id
        user.save!
      else
        account = Account.create( title: user.email, 
                                  user_id: user.id, 
                                  expiration_date: Date.current()>>1,
                                  contact_email: user.email,
                                  visits: 1,
                                  account_type: Account::ACCOUNT_TYPES[:not_confirmed] )
                                  
        AccountUser.where(user_id: user.id, account_id: account.id, role: 'Account Owner').first_or_create(user_id: user.id, account_id: account.id, role: 'Account Owner')
        
        user.account_id          = account.id
        user.current_account_id  = account.id
        user.save!
        
      end
    end
  
  end
end
