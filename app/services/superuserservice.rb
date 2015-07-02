class Superuserservice
  def self.doit

    User.supers.each do |user|
      account_user      = AccountUser.create(user_id: user.id, account_id: User.system_user.account.id)
      account_user.grand_all_permissions
      user.super_account_user_id = account_user.id
      user.save!
      ap user.super_account_user_id

    end
    
  end
end

# Superuserservice.doit