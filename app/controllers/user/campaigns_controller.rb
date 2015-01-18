class User::CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]

  before_filter :access_user
  include AccountsHelper

  def index
    @campaigns = @user.campaigns
  end



  def show
  end


  def new
    @campaign = Campaign.new
    #@recipient_groups = @user.account.client_groups
  end


  def edit
  end


  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.save!
    redirect_to user_user_campaign_path( @user, @campaign )
    #respond_to do |format|
    #  if @campaign.save
    #    format.html { redirect_to @campaign, notice: 'Campaign was successfully created.' }
    #    format.json { render :show, status: :created, location: @campaign }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @campaign.errors, status: :unprocessable_entity }
    #  end
    #end
  end



  def update
    @campaign.update(campaign_params)
    redirect_to user_user_campaign_path( @user, @campaign )
    #respond_to do |format|
    #  if @campaign.update(campaign_params)
    #    format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @campaign }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @campaign.errors, status: :unprocessable_entity }
    #  end
    #end
  end



  def destroy
    @campaign.destroy
    redirect_to user_campaigns_path( @user )
    #respond_to do |format|
    #  format.html { redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit!
    end
end
