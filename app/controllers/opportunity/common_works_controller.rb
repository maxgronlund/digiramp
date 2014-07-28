class Opportunity::CommonWorksController < ApplicationController
  include OpportunitiesHelper
  before_filter :access_opportunity
  
  def new
    @music_request   = MusicRequest.cached_find(params[:music_request_id])
    @common_work     = CommonWork.new
  end
  
  def show
    @music_request   = MusicRequest.cached_find(params[:music_request_id])
    @common_work     = CommonWork.cached_find(params[:id])
     #@common_work     = CommonWork.new
  end
  
  def index
    
  end
  
  def create
    ap params
    forbidden unless current_account_user.create_common_work
    
    
    
    artwork_url = TransloaditImageParser.get_image_url params[:transloadit]

    # extract  parameters
    params[:common_work]            = params["common_work"]
    
    # set the artwork url if any
    params[:common_work][:artwork]  = artwork_url if artwork_url
    
    
    if @common_work = CommonWork.create(common_work_params)
      @music_request   = MusicRequest.cached_find(params[:music_request_id])
      @common_work.update_completeness
      redirect_to opportunity_opportunity_music_request_common_work_path(@opportunity, @music_request, @common_work)
    else
      render :new
    end
  end
  
  def destroy
    @music_request   = MusicRequest.cached_find(params[:music_request_id])
    @common_work     = CommonWork.cached_find(params[:id])
    @common_work.destroy!
    
    redirect_to opportunity_opportunity_music_request_path(@opportunity, @music_request)
    
  end
  
private

  def common_work_params
    params.require(:common_work).permit!
  end
end
