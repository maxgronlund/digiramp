class MailCampaignsController < ApplicationController
  before_action :set_mail_campaign, only: [:show, :edit, :update, :destroy]

  # GET /mail_campaigns
  # GET /mail_campaigns.json
  def index
    @mail_campaigns = MailCampaign.all
  end

  # GET /mail_campaigns/1
  # GET /mail_campaigns/1.json
  def show
  end

  # GET /mail_campaigns/new
  def new
    @mail_campaign = MailCampaign.new
  end

  # GET /mail_campaigns/1/edit
  def edit
  end

  # POST /mail_campaigns
  # POST /mail_campaigns.json
  def create
    @mail_campaign = MailCampaign.new(mail_campaign_params)

    respond_to do |format|
      if @mail_campaign.save
        format.html { redirect_to @mail_campaign, notice: 'Mail campaign was successfully created.' }
        format.json { render :show, status: :created, location: @mail_campaign }
      else
        format.html { render :new }
        format.json { render json: @mail_campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mail_campaigns/1
  # PATCH/PUT /mail_campaigns/1.json
  def update
    respond_to do |format|
      if @mail_campaign.update(mail_campaign_params)
        format.html { redirect_to @mail_campaign, notice: 'Mail campaign was successfully updated.' }
        format.json { render :show, status: :ok, location: @mail_campaign }
      else
        format.html { render :edit }
        format.json { render json: @mail_campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mail_campaigns/1
  # DELETE /mail_campaigns/1.json
  def destroy
    @mail_campaign.destroy
    respond_to do |format|
      format.html { redirect_to mail_campaigns_url, notice: 'Mail campaign was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail_campaign
      @mail_campaign = MailCampaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mail_campaign_params
      params.require(:mail_campaign).permit(:account_id, :user_id, :title, :from_email, :from_title, :mail_layout_id, :subscription_message)
    end
end
