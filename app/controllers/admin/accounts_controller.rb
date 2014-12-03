class Admin::AccountsController < ApplicationController
  
  before_filter :admins_only
  
  def index
    @accounts   = Account.activated.search(params[:query]).order('lower(title) ASC').page(params[:page]).per(50)
    @user       = current_user
    @authorized = true
  end
  
  def show
     @account    = Account.cached_find(params[:id])
     @user       = current_user
     @authorized = true
  end
  
  def new
    ap params
    user = User.cached_find(params[:user_id])
    User.create_a_new_account_for_the user
    redirect_to :back
  end
  
  def create
    #ap params
    #User.create_a_new_account_for_the user
    #redirect_to :back
  end
  
  def edit
    @account = Account.cached_find(params[:id])
    @user       = current_user
    @authorized = true
  end
  
  def update
    @account = Account.cached_find(params[:id])
    
    # store administrator id
    old_administrator_id = @account.administrator_id
    # update
    @account.update_attributes(account_params)
    
    @account.create_activity(  :updated, 
                          owner: current_user,
                      recipient: @account,
                 recipient_type: @account.class.name,
                 account_id:     @account.id)
    
    # if the administrator is updated  
    if old_administrator_id != @account.administrator_id
      
     
      
      @account.reassign_administrator( old_administrator_id ) 

      flash[:warning] = { title: "NOTICE: ", body: "Rebuilding all permissions, might take a few seconds before completed" }
    else
      flash[:success] = { title: "SUCCESS: ", body: "Account updated" }
    end
    
    # the account owner can create opertunities
    if @account.create_opportunities
      account_user = AccountUser.cached_where(@account.id, @account.user_id)
      account_user.create_opportunity = true
      account_user.read_opportunity   = true
      account_user.save!
      #@account.account_users.supers.each do |super|
      #  
      #  
      #end
    else
      # no account_users can create opportunities
      @account.account_users.each do |account_user|
        account_user.create_opportunity   = false
        account_user.read_opportunity     = false
        account_user.update_opportunity   = false
        account_user.delete_opportunity   = false
        account_user.save!
      end
    end
    
    
    # go to the account
    redirect_to admin_account_path( @account)
  end
  
  
  
  def destroy
    begin
      @account = Account.cached_find(params[:id])
      @account_id = @account.id
      @account.create_activity(  :destroyed, 
                            owner: current_user,
                        recipient: @account,
                   recipient_type: @account.class.name)
                
      flash[:info] = { title: "SUCCESS: ", body: "Account #{@account.title} deleted" }
      
      if @account.user
        user = @account.user
        user.create_activity(  :destroyed, 
                              owner: current_user,
                          recipient: user,
                     recipient_type: user.class.name,
                         account_id: @account.id)
                     
        user.destroy! 
      end 
      @account.destroy!   
    rescue
      flash[:danger] = { title: "ERROR: ", body: "Unable to delete #{@account.title}" }
    end        
    #redirect_to admin_accounts_path
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
    params.require(:account).permit! if current_user.can_edit?
  end
end
