class Admin::DigirampAdsController < ApplicationController
  before_action :set_digiramp_ad, only: [:show, :edit, :update, :destroy]

  # GET /digiramp_ads
  # GET /digiramp_ads.json
  def index
    @digiramp_ads = DigirampAd.all
  end

  # GET /digiramp_ads/1
  # GET /digiramp_ads/1.json
  def show
  end

  # GET /digiramp_ads/new
  def new
    @digiramp_ad = DigirampAd.new
  end

  # GET /digiramp_ads/1/edit
  def edit
  end

  # POST /digiramp_ads
  # POST /digiramp_ads.json
  def create
    @digiramp_ad = DigirampAd.new(digiramp_ad_params)

    respond_to do |format|
      if @digiramp_ad.save
        format.html { redirect_to @digiramp_ad, notice: 'Digiramp ad was successfully created.' }
        format.json { render :show, status: :created, location: @digiramp_ad }
      else
        format.html { render :new }
        format.json { render json: @digiramp_ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /digiramp_ads/1
  # PATCH/PUT /digiramp_ads/1.json
  def update
    respond_to do |format|
      if @digiramp_ad.update(digiramp_ad_params)
        format.html { redirect_to @digiramp_ad, notice: 'Digiramp ad was successfully updated.' }
        format.json { render :show, status: :ok, location: @digiramp_ad }
      else
        format.html { render :edit }
        format.json { render json: @digiramp_ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /digiramp_ads/1
  # DELETE /digiramp_ads/1.json
  def destroy
    @digiramp_ad.destroy
    respond_to do |format|
      format.html { redirect_to digiramp_ads_url, notice: 'Digiramp ad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_digiramp_ad
      @digiramp_ad = DigirampAd.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def digiramp_ad_params
      params.require(:digiramp_ad).permit(:identifyer, :title, :body, :image, :snippet, :link, :button_link, :button_style, :css_snipet)
    end
end
