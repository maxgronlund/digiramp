class Account::ArtworksController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]

  include AccountsHelper
  before_filter :access_account

  
  
  def index
    @artworks = @account.artworks
  end

  # GET /artworks/1
  # GET /artworks/1.json
  def show
  end

  # GET /artworks/new
  def new
    forbidden unless current_account_user.create_artwork
    @artwork = Artwork.new
  end

  # GET /artworks/1/edit
  def edit
  end

  # POST /artworks
  # POST /artworks.json
  def create
    #forbidden unless current_catalog_user.create_artwork
    forbidden unless current_account_user.create_artwork
    artworks = TransloaditImageParser.artwork( params[:transloadit], @account.id)

    redirect_to  account_account_artworks_path(@account)

  end

  # PATCH/PUT /artworks/1
  # PATCH/PUT /artworks/1.json
  def update
    respond_to do |format|
      if @artwork.update(artwork_params)
        format.html { redirect_to @artwork, notice: 'Artwork was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @artwork.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artworks/1
  # DELETE /artworks/1.json
  def destroy
    @artwork.destroy
    respond_to do |format|
      format.html { redirect_to artworks_url }
      format.json { head :no_content }
    end
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
