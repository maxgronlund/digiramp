class SharedCatalogsController < ApplicationController
  #before_filter :there_is_access_to_the_account
  before_filter :access_user
  def index
    
  end

  def show
    @catalog_user = CatalogUser.where(user_id: @user.id, catalog_id: params[:id]).first
  end
  

end
