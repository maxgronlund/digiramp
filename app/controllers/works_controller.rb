class WorksController < ApplicationController
  include AccountsHelper
  before_filter :access_to_account
  
  def index
    
    @common_works  = CommonWork.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(32)
    respond_to do |format|
      format.html
      #format.csv { render text: @common_works.to_csv }
      format.csv { render text: @common_works.to_csv }
    end
  end

  def show
    
    @common_work    = CommonWork.cached_find(params[:id])
    
    # pessimistic locking
    access = false
    
    if @common_work.is_accessible_by current_user
      access                                = true
      @user_can_access_shared_with          = true
      @user_can_access_files                = true
      @user_can_access_legal_documents      = true
      @user_can_access_financial_documents  = true
      @user_can_access_ipis                 = true
      @can_delete                           = true
      @can_edit                             = true
    elsif work_user = WorkUser.cached_where(@common_work.id, current_user.id)
      access                                = true
      @user_can_access_files                = work_user.access_files
      @user_can_access_legal_documents      = work_user.access_legal_documents
      @user_can_access_financial_documents  = work_user.access_financial_documents
      if @user_can_access_ipis              = work_user.access_ipis
        @show_more      = true
      end
    end
      
    if access 
      render :show
    else
      render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
    end
  end
  
  def edit
    @common_work    = CommonWork.find(params[:id])
  end
  
  def update
    @common_work    = CommonWork.cached_find(params[:id])
    if @common_work.update_attributes(common_work_params)
      @common_work.update_completeness
      redirect_to_return_url account_work_path(@account, @common_work)
    else
      render :edit
    end
  end
  
  def destroy
    @common_work    = CommonWork.cached_find(params[:id])
    @common_work.destroy
    redirect_to account_works_path @account

  end
  
private
  
  def common_work_params
    params.require(:common_work).permit!
  end
  
  
end
