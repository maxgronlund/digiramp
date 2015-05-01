class Admin::DigirampAdsController < ApplicationController
  before_action :set_digiramp_ad, only: [:show, :edit, :update, :destroy]
  
  include UsersHelper
  before_action :admin_only

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
    @digiramp_ad = DigirampAd.create(digiramp_ad_params)

    redirect_to admin_digiramp_ads_path
  end

  # PATCH/PUT /digiramp_ads/1
  # PATCH/PUT /digiramp_ads/1.json
  def update
    @digiramp_ad.update(digiramp_ad_params)
    redirect_to admin_digiramp_ads_path
  end

  # DELETE /digiramp_ads/1
  # DELETE /digiramp_ads/1.json
  def destroy
    @digiramp_ad.destroy
    redirect_to admin_digiramp_ads_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_digiramp_ad
      @digiramp_ad = DigirampAd.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def digiramp_ad_params
      params.require(:digiramp_ad).permit!
    end
end
