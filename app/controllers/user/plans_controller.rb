class User::PlansController < ApplicationController
  before_filter :access_user
  
  before_filter :obsolete
  
  def obsolete
    ap '===================================================='
    ap '===================================================='
    ap '      !!! PAYPAL NO LONGER SUPPORTED                '
    ap '===================================================='
    ap '===================================================='
    
  end
  
  
  def index
    if account = @user.account
      @current_account_type = account.account_type
      @account_features  =  AccountFeature.order(:position).where(enabled: true)
      
    end
  end
end
