class Account::CommonWorksController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  before_filter :access_account
  
  # show list or export as cvs
  def index
    @common_works  = CommonWork.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(32)
    respond_to do |format|
      format.html
      #format.csv { render text: @common_works.to_csv }
      format.csv { render text: @common_works.to_csv }
    end
  end

  def show
    forbidden unless current_account_user.read_common_work
    @common_work    = CommonWork.cached_find(params[:id])
  end
  
  def edit
    forbidden unless current_account_user.update_common_work
    @common_work    = CommonWork.find(params[:id])
  end
  
  def update
    forbidden unless current_account_user.update_common_work
    artwork_url = TransloaditImageParser.get_image_url params[:transloadit]

    # extract  parameters
    params[:common_work] = params["common_work"]
    
    # set the artwork url if any
    params[:common_work][:artwork]  = artwork_url if artwork_url

    
    @common_work    = CommonWork.cached_find(params[:id])
    if @common_work.update_attributes(common_work_params)
      @common_work.update_completeness
      redirect_to_return_url account_work_path(@account, @common_work)
    else
      render :edit
    end
  end
  
  def destroy
    forbidden unless current_account_user.delete_common_work
    @common_work    = CommonWork.cached_find(params[:id])
    @common_work.destroy
    redirect_to account_works_path @account

  end
  
private
  
  def common_work_params
    params.require(:common_work).permit!
  end
  
  
end
