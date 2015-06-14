class Admin::MandrillAccountsController < ApplicationController
  before_action :admin_only

  # GET /admin/mandrill_accounts
  # GET /admin/mandrill_accounts.json
  def index
    @users = User.search(params[:query]).order('lower(email) ASC').page(params[:page]).per(50)
  end

  # GET /admin/mandrill_accounts/1
  # GET /admin/mandrill_accounts/1.json
  def show
  end

 

 

 

  
end
