class CmsSocialLinksController < ApplicationController
  before_action :set_cms_social_link, only: [:show, :edit, :update, :destroy]

  # GET /cms_social_links
  # GET /cms_social_links.json
  def index
    @cms_social_links = CmsSocialLink.all
  end

  # GET /cms_social_links/1
  # GET /cms_social_links/1.json
  def show
  end

  # GET /cms_social_links/new
  def new
    @cms_social_link = CmsSocialLink.new
  end

  # GET /cms_social_links/1/edit
  def edit
  end

  # POST /cms_social_links
  # POST /cms_social_links.json
  def create
    @cms_social_link = CmsSocialLink.new(cms_social_link_params)

    respond_to do |format|
      if @cms_social_link.save
        format.html { redirect_to @cms_social_link, notice: 'Cms social link was successfully created.' }
        format.json { render :show, status: :created, location: @cms_social_link }
      else
        format.html { render :new }
        format.json { render json: @cms_social_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cms_social_links/1
  # PATCH/PUT /cms_social_links/1.json
  def update
    respond_to do |format|
      if @cms_social_link.update(cms_social_link_params)
        format.html { redirect_to @cms_social_link, notice: 'Cms social link was successfully updated.' }
        format.json { render :show, status: :ok, location: @cms_social_link }
      else
        format.html { render :edit }
        format.json { render json: @cms_social_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cms_social_links/1
  # DELETE /cms_social_links/1.json
  def destroy
    @cms_social_link.destroy
    respond_to do |format|
      format.html { redirect_to cms_social_links_url, notice: 'Cms social link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_social_link
      @cms_social_link = CmsSocialLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cms_social_link_params
      params.require(:cms_social_link).permit(:position, :user_id)
    end
end
