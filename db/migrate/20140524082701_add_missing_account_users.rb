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
        unless account.permitted_user_ids.include?  spider_man.id
          puts "spider man is not on the guest list, so go ahead and add him"
          account.permitted_user_ids << spider_man.id
          AccountPermissions.grand_all_permissions spider_man.id, account
          account.save!
        end
        
        if AccountUser.where(user_id: spider_man.id, account_id: account.id).first.nil?
          puts "There is no account user for spiderman so create one"
          account_user = AccountUser.create!(user_id: spider_man.id, account_id: account.id, role: "Super")
          AccountPermissions.grand_all_permissions spider_man.id, account
        end
        
      end
      
      
    end
  end
end
