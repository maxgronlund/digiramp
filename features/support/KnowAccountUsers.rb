module KnowAccountUsersHelper

  def find_or_create_account_user  account_id, user_id
    @account_user  ||= AccountUser.where(account_id: account_id, user_id: user_id)
                                  .first_or_create(account_id: account_id, user_id: user_id)
    
  end
  
end

World(KnowAccountUsersHelper)