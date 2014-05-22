module AccountsHelper
  
  
 
  
  def access_to_account
    forbidden if current_user == nil
    if params[:account_id]
      @account = Account.cached_find(params[:account_id])
    else
      @account = Account.cached_find(params[:id])
    end
    forbidden unless @account.permitted_user_ids.include? current_user.id
  end
  

  
  
end
