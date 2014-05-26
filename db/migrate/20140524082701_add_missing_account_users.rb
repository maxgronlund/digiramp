class AddMissingAccountUsers < ActiveRecord::Migration
  def change

    
    Account.all.each do |account|
      account.permitted_user_ids.each do |user_id|
        if AccountUser.where(account_id: account.id, user_id: user_id).nil?
          if account.user_id == user_id
            account_user = AccountUser.create!(user_id: user_id, account_id: account.id, role: "Account Owner")
          else
            account.permitted_user_ids -= [user_id]
            account.save!
          end
        end
      end
      
      User.supers.each do |spider_man|
        
        account_user = AccountUser.where( user_id: spider_man.id, 
                                          account_id: account.id)
                                  .first_or_create( user_id: spider_man.id, 
                                                    account_id: account.id, 
                                                    role: "Super")
        
        #AccountPermissions.grand_all_permissions account_user
        
        unless account.permitted_user_ids.include?  spider_man.id
          account.permitted_user_ids << spider_man.id
          account.save!
        end
        
        
        
      end
      
      
    end
  end
end
