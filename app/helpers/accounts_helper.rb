module AccountsHelper

  #def current_account_user
  #  puts '------------------- current_account_user --------------------'
  #  puts @account.title
  #  puts current_user.email
  #  puts '----------------------------------------'
  #  
  #  AccountUser.cached_where( @account.id, current_user.id)
  #end
  
  def access_account
    return forbidden if current_user.nil?
    

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

    
    #forbidden unless @account.permitted_user_ids.include? current_user.id

  end
  
  #def access_account
  #
  #  forbidden if current_user == nil
  #  if params[:account_id]
  #    @account = Account.cached_find(params[:account_id])
  #  elsif
  #    @account = Account.cached_find(params[:id])
  #  elsif session[:account_id]
  #    @account = Account.cached_find( session[:account_id])
  #  end
  #  not_found unless @account
  #  @account
  #end
  
  #def current_account
  #  access_to_account
  #end
  
  

  
end
