class Account::CommonWorkArtworksController < ApplicationController
  
  
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  before_action :access_account
  
  
  def index
    @common_work = CommonWork.cached_find(params[:common_work_id])
  end

  def show
  end

  def new
    @common_work = CommonWork.cached_find(params[:common_work_id])
    @common_work_item = CommonWorkItem.new
  end

  def edit
  end
  

  
  # POST /artworks
  # POST /artworks.json
  def create
    forbidden unless current_account_user.create_artwork
    @common_work = CommonWork.cached_find(params[:common_work_id])
    artworks = TransloaditImageParser.artwork( params[:transloadit], @account.id)
    
    artworks.each do |artwork|
      CommonWorkItem.create( common_work_id: @common_work.id, 
                             attachable_type: 'Artwork',
                             attachable_id: artwork.id,
                             account_id: @account.id,
                             user_uuid: current_user.uuid
                            )
      
    end

    
    redirect_to  account_account_common_work_common_work_artworks_path(@account, @common_work)

  end
  
  
end
