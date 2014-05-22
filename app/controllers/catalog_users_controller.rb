class CatalogUsersController < ApplicationController
  
  include AccountsHelper
  before_filter :access_to_account
  
  def index
    @catalog        = Catalog.cached_find(params[:catalog_id])
  end
  
  
  def new
    @catalog        = Catalog.cached_find(params[:catalog_id])
    @catalog_user   = CatalogUser.new
  end
  
  def create
    @catalog                            = Catalog.cached_find(params[:catalog_id])
      if @user                          = User.invite_to_catalog_by_email(  params[:catalog_user][:email], 
                                                                            params[:catalog_user][:title],
                                                                            params[:catalog_user][:body],
                                                                            @catalog.id
                                                                          )
      params[:catalog_user][:user_id]   = @user.id 
      @catalog_user                     = CatalogUser.create(catalog_user_params)
      
      RecordingPermissions.create_catalog_user_permissions @catalog, @catalog_user
      
    end
    redirect_to account_catalog_catalog_users_path(@account, @catalog)
  end

  def edit
    @catalog        = Catalog.cached_find(params[:catalog_id])
    @catalog_user   = CatalogUser.cached_find(params[:id])
  end
  
  def update
    @catalog        = Catalog.cached_find(params[:catalog_id])
    @catalog_user   = CatalogUser.cached_find(params[:id])
    @catalog_user.update_attributes(catalog_user_params)
    RecordingPermissions.update_catalog_user_permissions @catalog, @catalog_user

    redirect_to account_catalog_catalog_users_path(@account, @catalog)
  end
  
  def destroy
    @catalog        = Catalog.cached_find(params[:catalog_id])
    @catalog_user   = CatalogUser.cached_find(params[:id])
    RecordingPermissions.delete_catalog_user_permissions @catalog, @catalog_user
    @catalog_user.destroy
    
    redirect_to account_catalog_catalog_users_path(@account, @catalog)
  end
  
  private
  
  def catalog_user_params
    params.require(:catalog_user).permit!
  end
  
  def set_permission_on recordings
    
    
    
  end
  
  
end
