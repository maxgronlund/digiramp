class SharedCatalogsController < ApplicationController
  
  #include AccountsHelper
  include UsersHelper
  include CatalogsHelper
  #before_filter :access_to_account
  
  
  #include AccountsHelper
  #before_filter :access_to_account
  before_filter :access_user
  before_filter :access_catalog
  def index
    
  end

  def show
    @catalog_user = CatalogUser.where(user_id: @user.id, catalog_id: params[:id]).first
  end
  
  def edit
    @catalog_user = CatalogUser.where(user_id: @user.id, catalog_id: @catalog.id).first
    forbidden unless @catalog_user.edit_recordings
  end
  
  def update
    @catalog = Catalog.cached_find(params[:id])
    @catalog.update_attributes(catalog_params)
    flash[:info] = { title: "SUCCESS: ", body: "Catalog updated" }
    redirect_to user_shared_catalog_path(@user, @catalog)
  end
  
  def destroy
    catalog_user = CatalogUser.cached_where(@catalog.id, @user.id)
    catalog_user.destroy
    redirect_to user_shared_catalogs_path(@user)
  end
  
  def export_all
    flash[:info] = { title: "SUCCESS: ", body: "Catalog exported as csv" }
    
    #@catalog = Catalog.cached_find(params[:id])
    
    @catalog       = Catalog.cached_find(params[:shared_catalog_id])
    
    if recording_ids   = @catalog.catalog_items.where(catalog_itemable_type: "Recording").pluck(:catalog_itemable_id)
      @recordings      = Recording.where(id: recording_ids).order(:title)
      respond_to do |format|
        format.csv { render text: @recordings.to_csv }
      end
    end

  end
  
  
    
  
private

  def catalog_params
    
    params.require(:catalog).permit!
  end  

end
