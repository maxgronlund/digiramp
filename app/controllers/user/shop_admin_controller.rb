class User::ShopAdminController < ApplicationController
  before_action :access_user
  def index
    if @user.has_enabled_shop 
      @email_groups = EmailGroup.where(subscripeable: true)
      @shop_products = @user.products
      #redirect_to user_user_controll_panel_index_path( @user )
    else
      redirect_to user_user_create_shop_index_path(@user)
    end
    
  end
end
