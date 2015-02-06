class CmsPlaylistLinksController < ApplicationController
  before_action :set_cms_playlist_link, only: [:show, :edit, :update, :destroy]

  # GET /cms_playlist_links
  # GET /cms_playlist_links.json
  def index
    @cms_playlist_links = CmsPlaylistLink.all
  end

  # GET /cms_playlist_links/1
  # GET /cms_playlist_links/1.json
  def show
  end

  # GET /cms_playlist_links/new
  def new
    @cms_playlist_link = CmsPlaylistLink.new
  end

  # GET /cms_playlist_links/1/edit
  def edit
  end

  # POST /cms_playlist_links
  # POST /cms_playlist_links.json
  def create
    @cms_playlist_link = CmsPlaylistLink.new(cms_playlist_link_params)

    respond_to do |format|
      if @cms_playlist_link.save
        format.html { redirect_to @cms_playlist_link, notice: 'Cms playlist link was successfully created.' }
        format.json { render :show, status: :created, location: @cms_playlist_link }
      else
        format.html { render :new }
        format.json { render json: @cms_playlist_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cms_playlist_links/1
  # PATCH/PUT /cms_playlist_links/1.json
  def update
    respond_to do |format|
      if @cms_playlist_link.update(cms_playlist_link_params)
        format.html { redirect_to @cms_playlist_link, notice: 'Cms playlist link was successfully updated.' }
        format.json { render :show, status: :ok, location: @cms_playlist_link }
      else
        format.html { render :edit }
        format.json { render json: @cms_playlist_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cms_playlist_links/1
  # DELETE /cms_playlist_links/1.json
  def destroy
    @cms_playlist_link.destroy
    respond_to do |format|
      format.html { redirect_to cms_playlist_links_url, notice: 'Cms playlist link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_playlist_link
      @cms_playlist_link = CmsPlaylistLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_playlist_link_params
      params.require(:cms_playlist_link).permit(:position, :playlist_id)
    end
end
