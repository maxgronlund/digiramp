class Admin::AccountsController < ApplicationController
  def index
    @accounts = Account.order('lower(title) ASC').page(params[:page]).per(14)
  end
  
  def show
    
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
  
  private 
  
  def account_params
    
    params.require(:account).permit!
  end
end
