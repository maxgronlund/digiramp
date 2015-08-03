class User::PlansController < ApplicationController
  before_action :access_user
  
  before_action :obsolete
  
  def obsolete
    # '===================================================='
    # '===================================================='
    # '      !!! PAYPAL NO LONGER SUPPORTED                '
    # '===================================================='
    # '===================================================='
    
  end
  
  
  def index
    if account = @user.account
      @current_account_type = account.account_type
      @account_features  =  AccountFeature.order(:position).where(enabled: true)
      
    end
  end
end
