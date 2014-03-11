class LeaveAccountsController < ApplicationController

  before_filter :there_is_access_to_the_account
  #respond_to :html, :xml, :json

  
  
  def destroy
    @account      = Account.cached_find(params[:account_id])
    account_user  = AccountUser.find_by_cached_id(params[:id])
    if current_user.can_edit? || current_user.id = account_user.user_id
      account_user.destroy
    end

    redirect_to_return_url user_path(@account.user)
    #redirect_to :back
  end
  

  
end
