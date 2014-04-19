class SharedCatalogsController < ApplicationController
  #before_filter :there_is_access_to_the_account
  before_filter :find_user, only: [:show, :index]
  def index
    
  end

  def show
    @catalog_user= CatalogUser.where(user_id: @user.id, catalog_id: params[:id]).first
  end
  
  def find_user
    
  end
private  
  def find_user
    if current_user
      @user = User.cached_find(params[:user_id])
    else
      render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
    end
  end
end
