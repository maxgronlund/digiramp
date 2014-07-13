class Account::MailCampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  include AccountsHelper
  before_filter :access_account
  # GET /campaigns
  # GET /campaigns.json
  def index
    @project      = Project.cached_find(params[:project_id])
    @campaigns  = MailCampaign.all
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
     @project      = Project.cached_find(params[:project_id])
    
  end

  # GET /campaigns/new
  # GET /project_tasks/new
  def new
    @project       = Project.cached_find(params[:project_id])
    @mail_campaign = MailCampaign.new
    @mail_campaign.status = 'Draft'
  end

  # GET /campaigns/1/edit
  def edit
    @project      = Project.cached_find(params[:project_id])
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @mail_campaign = MailCampaign.create(mail_campaign_params)
    @project      = Project.cached_find(params[:project_id])
    redirect_to account_account_project_mail_campaign_path(@account, @project, @mail_campaign)
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' }
        format.json { render :show, status: :ok, location: @campaign }
      else
        format.html { render :edit }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @mail_campaign = MailCampaign.cached_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mail_campaign_params
      params.require(:mail_campaign).permit!
    end
end
