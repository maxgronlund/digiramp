module AccountsHelper


  def access_account
    
    #return forbidden unless current_user
    return forbidden unless current_account_user
    
    if params[:account_id]
      @account = Account.cached_find(params[:account_id])
    elsif
      @account = Account.cached_find(params[:id])
    elsif session[:account_id]
      @account = Account.cached_find( session[:account_id])
    end
    
    return not_found unless @account
    session[:account_id] = @account.id
    @account  
  end
  
  # v2 used in the account name space to find the account
  # !!! broken
  def get_account_account
    return forbidden unless current_user
    @user = current_user
    if params[:account_id]
      @account    = Account.cached_find(params[:account_id])
    elsif
      @account = Account.cached_find(params[:id])
    elsif session[:account_id]
      @account = Account.cached_find( session[:account_id])
    end
    #@authorized = true
    return forbidden unless @account.can_be_accessed_by current_user
  end
  

  
  

  
end
