class AddAccessAccountToAccountUser < ActiveRecord::Migration
  def change
    add_column :account_users, :access_account, :boolean, default: false
    
    
    
    AccountUser.all.each do |account_user|
      
      account_user.access_account = has_access(account_user)
       account_user.save!
    end
  end
  
  

  def has_access account_user
    return true if account_user.read_crm
    return true if account_user.read_opportunity
    return true if account_user.read_client
    return false
  end
    
    
    
end
