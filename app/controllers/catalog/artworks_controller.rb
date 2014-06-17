class Catalog::ArtworksController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  include CatalogsHelper
  
  before_filter :access_account
  before_filter :access_catalog
  
  
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]

  # GET /artworks
  # GET /artworks.json
  def index
    artwork_ids = CatalogItem.where(catalog_id: @catalog.id, catalog_itemable_type: 'Artwork').pluck(:catalog_itemable_id)
    @artworks = Artwork.where(id: artwork_ids)
    @artworks = @catalog.artworks
  end

  # GET /artworks/1
  # GET /artworks/1.json
  def show
    forbidden unless current_catalog_user.read_artwork
  end

  # GET /artworks/new
  def new
    forbidden unless current_catalog_user.create_artwork
    @artwork = Artwork.new
  end

  # GET /artworks/1/edit
  def edit
    forbidden unless current_catalog_user.update_artwork
  end

  # POST /artworks
  # POST /artworks.json
  def create
    forbidden unless current_catalog_user.create_artwork

    artworks = TransloaditImageParser.catalog_artwork( params[:transloadit], @account.id, @catalog.id )
    
    artworks.each do |artwork|
      CatalogItem.create( catalog_id: @catalog.id, 
                          catalog_itemable_type: 'Artwork',
                          catalog_itemable_id: artwork.id)
      
    end

    #redirect_to account_common_work_recording_image_files_path(@account, @common_work, @recording)
    redirect_to  catalog_account_catalog_artworks_path(@account, @catalog)

  end

  # PATCH/PUT /artworks/1
  # PATCH/PUT /artworks/1.json
  def update
    forbidden unless current_catalog_user.read_artwork
    @artwork.update(artwork_params)
    redirect_to  catalog_account_catalog_artworks_path(@account, @catalog)
  end

  # DELETE /artworks/1
  # DELETE /artworks/1.json
  def destroy
    forbidden unless current_catalog_user.delete_artwork
    
    
    
    
    @artwork.destroy!
    redirect_to  catalog_account_catalog_artworks_path(@account, @catalog)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artwork
      @artwork = Artwork.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artwork_params
      params.require(:artwork).permit!
    end
end
