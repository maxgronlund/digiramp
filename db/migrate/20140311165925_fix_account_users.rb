class FixAccountUsers < ActiveRecord::Migration
  def change
    add_column :admins, :accounts_version , :integer, default: 0
    AccountUser.all.each do |account_user|
      account = account_user.account
      if account.nil?
        account_user.delete
      end
    end
    
    Account.all.each do |account|
      account_users = AccountUser.where(account_id: account.id, role: 'Account Owner')
      if account_users.empty?
        account.destroy
      end
    end
    
    User.all.each do |user|
      # all accounts the user has access to
      account_users = AccountUser.where(user_id: user.id)
      
      # hey the user has no access to any accounts
      if account_users.empty?
        # Accounts that is owned by the user
        accounts = Account.where(user_id: user.id)
        
        if accounts.empty?
          puts user.email
          
          
          new_account = Account.new(title: Account::SECRET_NAME, 
                                    user_id: user.id, 
                                    expiration_date: Date.current()>>1,
                                    contact_email: user.email,
                                    visits: 1,
                                    account_type: Account::ACCOUNT_TYPES[:not_confirmed],
                                    )
          new_account.save(validate: false)                     
          AccountUser.create(user_id: user.id, account_id: new_account.id, role: 'Account Owner')
        
          user.account_id          = new_account.id
          user.current_account_id  = new_account.id
          user.save
          

          
        end
      end
    end
    
    Account.all.each do |account|
      account.expiration_date =  Date.current()>>1
      account.save!
    end

  end
end
