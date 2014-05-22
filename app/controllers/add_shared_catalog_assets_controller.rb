class AddSharedCatalogAssetsController < ApplicationController
  before_filter :access_user
  before_filter :access_to_catalog


  def show
    @catalog_user = CatalogUser.where(user_id: @user.id, catalog_id: params[:id]).first
  end
  

private

  def catalog_params
    
    params.require(:catalog).permit!
  end  
end
