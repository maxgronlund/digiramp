class CatalogWorksController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  include CatalogsHelper
  before_filter :access_to_account
  before_filter :access_catalog, only: [:index, :show, :edit, :update]
  
  def index
    forbidden unless current_catalog_user.read_common_work
    #@common_works = @catalog.common_works 
    
    
    
    
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
      @common_work.update_completeness
      redirect_to_return_url account_catalog_catalog_work_path(@account, @catalog, @common_work)
    else
      render :edit
    end
  end
  
private

  def common_work_params
    params.require(:common_work).permit!
  end
  
end
