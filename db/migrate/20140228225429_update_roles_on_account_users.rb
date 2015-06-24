class UpdateRolesOnAccountUsers < ActiveRecord::Migration
  def change
    
    AccountUser.all.each do |account_user|
      if Account.exists?(account_user.account.id)
        unless account_user.role == 'Administrator'
          account_user.role = 'Client'
          account_user.save!
        end
        if User.exists?(account_user.user_id)
          if account_user.account.user_id == account_user.user.id
            account_user.role = 'Account Owner'
            account_user.save!
          end
        else
          account_user.destroy
        end
      else
        account_user.destroy
      end
    end
  end
end
