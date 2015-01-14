class User::AddContactsController < ApplicationController
  
  before_filter :access_user
  
  
  def index
    @contact_group = ClientGroup.cached_find(params[:contact_group_id])
    @account    = @user.account
    @contacts  = Client.account_search(@account, params[:query]).order('name asc').page(params[:page]).per(16)
  end
end
