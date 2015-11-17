class User::CreateShopController < ApplicationController
  before_action :access_user
  include ErrorNotification
  def index
    
    if @user.is_stripe_connected
      redirect_to user_user_shop_admin_index_path(@user)
    else
      post_error "User::CreateShopController id: #{current_user.email} try to create a shop "
    end
  end
end
