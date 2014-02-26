class Admin::AccountsController < ApplicationController
  
  before_filter :admins_only
  
  def index
    @accounts = Account.order('lower(title) ASC').page(params[:page]).per(14)
  end
  
  def show
     @account = Account.find(params[:id])
  end
  
  def new
    
  end
  
  def edit
    @account = Account.find(params[:id])
  end
  
  def update
    @account = Account.find(params[:id])
    @account.update_attributes(account_params)
    redirect_to edit_admin_account_path( @account)
  end
  
  def destroy
    @account = Account.find(params[:id])
    flash[:info] = { title: "Success", body: "Account #{@account.title} deleted" }
    @account.destroy
    redirect_to admin_accounts_path
  end
  
  private 
  
  def account_params
    params.require(:account).permit! if current_user.can_edit?
  end
end
