class Account::CrmController < ApplicationController
  include AccountsHelper
  before_filter :access_account
  
  def index
    
    @user = @account.user
    @authorized = true
    
  end
end
