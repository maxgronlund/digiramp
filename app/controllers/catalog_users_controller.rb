class CatalogUsersController < ApplicationController
  
  before_filter :there_is_access_to_the_account
  
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
    redirect_to account_catalog_catalog_users_path(@account, @catalog)
  end
  
  def destroy
    @catalog        = Catalog.cached_find(params[:catalog_id])
    @catalog_user   = CatalogUser.cached_find(params[:id])
    @catalog_user.destroy
    redirect_to account_catalog_catalog_users_path(@account, @catalog)
  end
  
  private
  
  def catalog_user_params
    params.require(:catalog_user).permit!
  end
  
  
end
