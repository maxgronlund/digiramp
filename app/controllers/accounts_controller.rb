class AccountsController < ApplicationController
  
  include AccountsHelper
  before_action :access_account


  def show
    session[:account_id]  = @account.id
  end
  
  def edit
    @user = @account.user
  end
  
  def update
    @account  = Account.cached_find(params[:id])
    @account.update_attributes(account_params)

    redirect_to user_path(  @account.user)

  end
  
private

  def account_params
    params.require(:account).permit!
  end

  


end
