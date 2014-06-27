class Account::MusicRequestsController < ApplicationController
  before_action :set_music_request, only: [:show, :edit, :update, :destroy]
  
  include AccountsHelper
  before_filter :access_account

  # GET /opportunities
  # GET /opportunities.json
  def index
    forbidden unless current_account_user.read_opportunity
    #@opportunities = Opportunity.all
  end

  # GET /opportunities/1
  # GET /opportunities/1.json
  def show
    forbidden unless current_account_user.read_opportunity
  end

  # GET /opportunities/new
  def new
    forbidden unless current_account_user.update_opportunity
    @opportunity    = Opportunity.cached_find(params[:opportunity_id])
    @music_request  = MusicRequest.new
  end

  # GET /opportunities/1/edit
  def edit
    forbidden unless current_account_user.update_opportunity
    @opportunity    = Opportunity.cached_find(params[:opportunity_id])
    
  end

  # POST /opportunities
  # POST /opportunities.json
  def create
    forbidden unless current_account_user.update_opportunity
     @opportunity    = Opportunity.cached_find(params[:opportunity_id])
    if @music_request = MusicRequest.create(music_request_params)
      redirect_to account_account_opportunity_path(@account, @opportunity)
    else
      
    end
    #
    #if @opportunity.save
    #  flash[:info]      = { title: "Success", body: "Opportunity Created" }
    #  redirect_to account_account_opportunity_path(@account, @opportunity)
    #   
    #else
    #  flash[:danger]      = { title: "Error", body: "Unable to create opportunity" }
    #  redirect_to new_account_account_opportunity_path(@account)
    #end
    #
  end

  # PATCH/PUT /opportunities/1
  # PATCH/PUT /opportunities/1.json
  def update
    forbidden unless current_account_user.update_opportunity
    @opportunity    = Opportunity.cached_find(params[:opportunity_id])
    if @music_request.update(music_request_params)
      flash[:info]      = { title: "Success", body: "Music Request Updated" }
      redirect_to account_account_opportunity_path(@account, @opportunity)
    else
      flash[:danger]      = { title: "Error", body: "Unable to update Music Request" }
      redirect_to new_account_account_opportunity_path(@account)
    end

  end

  # DELETE /opportunities/1
  # DELETE /opportunities/1.json
  def destroy
    forbidden unless current_account_user.delete_opportunity
    @music_request.destroy
    redirect_to account_account_opportunities_path(@account)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_music_request
      @music_request = MusicRequest.cached_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def music_request_params
      params.require(:music_request).permit!
    end
end
