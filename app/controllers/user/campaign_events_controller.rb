class User::CampaignEventsController < ApplicationController
  before_action :set_campaign_event, only: [:show, :edit, :update, :destroy]
  before_filter :access_user
  include AccountsHelper

  # GET /campaign_events
  # GET /campaign_events.json
  def index
    
    @campaign_events = CampaignEvent.all
  end

  # GET /campaign_events/1
  # GET /campaign_events/1.json
  def show
  end

  # GET /campaign_events/new
  def new
    @campaign = Campaign.cached_find(params[:campaign_id])
    @campaign_event = CampaignEvent.new
  end

  # GET /campaign_events/1/edit
  def edit
  end

  # POST /campaign_events
  # POST /campaign_events.json
  def create
    @campaign_event = CampaignEvent.create(campaign_event_params)
    redirect_to user_user_campaign_path(@user, @campaign_event.campaign)
    
  end

  # PATCH/PUT /campaign_events/1
  # PATCH/PUT /campaign_events/1.json
  def update
    respond_to do |format|
      if @campaign_event.update(campaign_event_params)
        format.html { redirect_to @campaign_event, notice: 'Campaign event was successfully updated.' }
        format.json { render :show, status: :ok, location: @campaign_event }
      else
        format.html { render :edit }
        format.json { render json: @campaign_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaign_events/1
  # DELETE /campaign_events/1.json
  def destroy
    @campaign_event.destroy
    respond_to do |format|
      format.html { redirect_to campaign_events_url, notice: 'Campaign event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign_event
      @campaign_event = CampaignEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_event_params
      params.require(:campaign_event).permit!
    end
end
