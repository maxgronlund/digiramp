class Account::CrmController < ApplicationController
  include AccountsHelper
  before_action :access_account
  
  def index
    
    @user = @account.user
    @authorized = true
    
  end
end
