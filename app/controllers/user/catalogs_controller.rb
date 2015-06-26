class User::CatalogsController < ApplicationController
  
  before_action :access_user, only: [:show, :edit, :update, :destroy, :index]

  
  def index
    #@user = current_user
    @authorized = true
    @user_account  = Account.cached_find(@user.account.id)
    catalog_ids   = CatalogUser.where(user_id: @user.id ).pluck(:catalog_id)
    @catalogs      = Catalog.order('title asc').where(id: catalog_ids)
  end

  
end
