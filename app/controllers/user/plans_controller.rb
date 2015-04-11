class User::PlansController < ApplicationController
  before_filter :access_user
  def index
    if account = @user.account
      @current_account_type = account.account_type
      @account_features  =  AccountFeature.order(:position).where(enabled: true)
      
    end
  end
end
