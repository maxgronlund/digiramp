class Admin::AccountsController < ApplicationController
  
  before_action :admins_only
  
  def index
    #@accounts   = Account.activated.search(params[:query]).order('lower(title) ASC').page(params[:page]).per(50)
    @accounts   = Account.search(params[:query]).order('id desc').page(params[:page]).per(50)
    #@user = current_user
  end
  
  def show
     @account    = Account.cached_find(params[:id])
     if @account.nil?
       not_found 
     else
    end
     
  end
  
  def new
    redirect_to :back
  end
  
  def create
  end
  
  def edit
    @account    = Account.cached_find(params[:id])
    not_found if @account.nil?
  end
  
  def update
    @account = Account.cached_find(params[:id])
    
    # store administrator id
    old_administrator_id  = @account.administrator_id
    # store account type
    old_account_type      = @account.account_type
    
    # update
    if @account.update_attributes(account_params)
    
      # if the account type is updated
      @account.update_account_type if @account.account_type != old_account_type
      
      # if the administrator is updated  
      @account.reassign_administrator( old_administrator_id ) if old_administrator_id != @account.administrator_id
      
      
      
      @account.create_activity(  :updated, 
                            owner: current_user,
                        recipient: @account,
                   recipient_type: @account.class.name,
                   account_id:     @account.id
                   )
      
      # go to the account
      @account.user.update(account_type: @account.account_type)
      redirect_to admin_account_path( @account)
    else
      render :edit
    end
  end
  
  
  
  def destroy
    
    @account    = Account.cached_find(params[:id])
    @account_id = @account.id
    user        = @account.user
    
    unless current_user.id == @account.user_id
      @account.destroy!
      if user
        user.destroy
      end
    end

    
      #@account    = Account.cached_find(params[:id])
      
      #@account.destroy!   
  end
  
  def delete_common_works
    @account = Account.cached_find(params[:account_id])
    @account.common_works.destroy_all
    #AccountCache.update_works_uuid @account
    @account.update_assets_count
    redirect_to :back
  end
  
  def delete_recordings
    @account = Account.cached_find(params[:account_id])
    @account.recordings.destroy_all
    @account.update_assets_count
    redirect_to :back
  end
  
  def delete_documents
    @account = Account.cached_find(params[:account_id])
    @account.attachments.destroy_all
    @account.update_assets_count
    redirect_to :back
  end
  
  def delete_clients
    @account = Account.cached_find(params[:account_id])
    # add worker here
    @account.clients.destroy_all
    redirect_to :back
  end

  
  def repair_users
    @account = Account.cached_find(params[:account_id])
    @account.repair_users
    redirect_to :back
  end
  
  
  def repair_recordings
    @account = Account.cached_find(params[:account_id])
    RepairRecordingsWorker.perform_async(@account.id)
    
    #@account = Account.cached_find(params[:account_id])
    #@account.repair_recordings
    redirect_to admin_account_path( @account)
  end
  
  def repair_works
    @account = Account.cached_find(params[:account_id])
    @account.repair_works
    redirect_to :back
  end
  
  def repair_catalogs
    @account = Account.cached_find(params[:account_id])
    redirect_to :back
  end
  

  
  private 
  
  def account_params
    if super?
      params.require(:account).permit(AccountParams::ADMIN_PARAMS)
    else
      forbidden
    end
  end
end
