class CatalogWorksController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  include CatalogsHelper
  before_action :access_account
  before_action :access_catalog, only: [:index, :show, :edit, :update, :destroy]
  
  
  # is this used?
  def index
    forbidden unless current_catalog_user.read_common_work

    @common_works  = CommonWork.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(32)
    respond_to do |format|
      format.html
      #format.csv { render text: @common_works.to_csv }
      format.csv { render text: @common_works.to_csv }
    end
  end
  
  def show
    forbidden unless current_catalog_user.read_common_work
    @common_work = CommonWork.cached_find(params[:id])
  end
  
  def edit
    forbidden unless current_catalog_user.update_common_work
    @common_work    = CommonWork.find(params[:id])
  end
  
  
  def update
    forbidden unless current_catalog_user.update_common_work
    # get the artwork url
    artwork_url = TransloaditImageParser.get_image_url params[:transloadit]

    # extract  parameters
    params[:common_work] = params["common_work"]
    
    # set the artwork url if any
    params[:common_work][:artwork]  = artwork_url if artwork_url

    
    @common_work    = CommonWork.cached_find(params[:id])
    if @common_work.update_attributes(common_work_params)
      
      @common_work.create_activity(  :updated, 
                                owner: current_user,
                            recipient: @common_work,
                       recipient_type: @common_work.class.name,
                           account_id: @account.id)
                           
                           
      @common_work.update_completeness
      redirect_to_return_url account_catalog_catalog_work_path(@account, @catalog, @common_work)
    else
      render :edit
    end
  end
  
  def destroy
    forbidden unless current_catalog_user.delete_common_work
    @common_work = CommonWork.cached_find(params[:id])
    @common_work.destroy
    redirect_to_return_url account_catalog_catalog_works_path(@account, @catalog)
  end
  
  
  
private

  def common_work_params
    params.require(:common_work).permit!
  end
  
end
