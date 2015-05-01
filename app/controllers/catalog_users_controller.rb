class CatalogUsersController < ApplicationController
  
  include AccountsHelper
  before_action :access_to_account
  
  def index
    @catalog        = Catalog.cached_find(params[:catalog_id])
    @user           = current_user
  end
  
  
  def new
    @catalog        = Catalog.cached_find(params[:catalog_id])
    @catalog_user   = CatalogUser.new( title: "You have been invited to a DigiRAMP Catalog by #{current_user.name}", 
                                       body: "You are invited to a Catalog on DigiRAMP. You can access it from #{@catalog.account.title} on your home page",
                                       account_id: @catalog.account_id,
                                       uuid:       UUIDTools::UUID.timestamp_create().to_s)
  end
  
  def create
    @catalog        = Catalog.cached_find(params[:catalog_id])
    if @user        = User.invite_to_catalog_by_email(  params[:catalog_user][:email], 
                                                        params[:catalog_user][:title],
                                                        params[:catalog_user][:body],
                                                        @catalog.id
                                                     )
    
      params[:catalog_user][:user_id]      = @user.id 
      params[:catalog_user][:account_id]   = @account.id
      params[:catalog_user][:uuid]         = UUIDTools::UUID.timestamp_create().to_s
      @catalog_user                        = CatalogUser.create!(catalog_user_params)
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
    forbiden unless current_account_user.delete_user
    
    @catalog        = Catalog.cached_find(params[:catalog_id])
    @catalog_user   = CatalogUser.cached_find(params[:id])
    
    # store account and user
    account       = @catalog_user.account
    user          = @catalog_user.user
    account_user = AccountUser.where(account_id: @catalog_user.account_id, user_id: @catalog_user.user_id).first
    

    @catalog_user.destroy!
    
    # if the account user was created when the user was invited to a scatlog
    if account_user.role == 'Catalog User'
     
      
      # and there is no more catalog users for the account user
      if CatalogUser.where(user_id: user.id, account_id: account.id, catalog_id: @catalog.id).first.nil?
        
        # It's safe do destroy the account user, unless the account user is the accoun owner ;-)
        account_user.destroy! unless account.user_id == account_user.user_id
      end
    end
    
    
    redirect_to account_catalog_catalog_users_path(@account, @catalog)
  end
  
  private
  
  def catalog_user_params
    params.require(:catalog_user).permit!
  end
  
  def set_permission_on recordings
    
    
    
  end
  
  
end
