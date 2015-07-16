class User::CreateShopController < ApplicationController
  before_action :access_user
  def index
    
    if @user.is_stripe_connected
      redirect_to user_user_shop_admin_index_path(@user)
    else
      
    end
  end
end
