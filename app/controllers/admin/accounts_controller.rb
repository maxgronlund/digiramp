class Admin::AccountsController < ApplicationController
  def index
    @accounts = Account.order('lower(title) ASC').page(params[:page]).per(14)
  end
  
  def show
    
  end
  
  def new
    
  end
end
