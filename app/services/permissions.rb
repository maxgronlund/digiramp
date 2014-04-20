class Permissions
  
  def initialize
  end
  
  def self.can_access_private_account current_user, account_user
    # passimistic locking
    access = false
    
    if current_user
    # no access for users not signed in 
      if current_user.id == account_user.id
         # all users have access to their own account
        access =  true
      else current_user.super?
        # super user can access all private accounts
        access =  true
      end
    end
    access
  end
  
end

