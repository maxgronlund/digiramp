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
    forbidden unless current_account_user.can_access_work @common_work
   
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
