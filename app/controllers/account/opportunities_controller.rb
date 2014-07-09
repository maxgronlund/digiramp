class Account::OpportunitiesController < ApplicationController
  before_action :set_opportunity, only: [:show, :edit, :update, :destroy]
  
  include AccountsHelper
  before_filter :access_account

  # GET /opportunities
  # GET /opportunities.json
  def index
    forbidden unless current_account_user.read_opportunity
    @opportunities = @account.opportunities
  end

  # GET /opportunities/1
  # GET /opportunities/1.json
  def show
    forbidden unless current_account_user.read_opportunity
  end

  # GET /opportunities/new
  def new
    forbidden unless current_account_user.create_opportunity
    @opportunity = Opportunity.new
  end

  # GET /opportunities/1/edit
  def edit
    forbidden unless current_account_user.update_opportunity
  end

  # POST /opportunities
  # POST /opportunities.json
  def create
    forbidden unless current_account_user.create_opportunity
    @opportunity = Opportunity.new(opportunity_params)
    
    if @opportunity.save
      flash[:info]      = { title: "Success", body: "Opportunity Created" }
      redirect_to account_account_opportunity_path(@account, @opportunity)
       
    else
      flash[:danger]      = { title: "Error", body: "Unable to create opportunity" }
      redirect_to new_account_account_opportunity_path(@account)
    end

    #respond_to do |format|
    #  if @opportunity.save
    #    format.html { redirect_to @opportunity, notice: 'Opportunity was successfully created.' }
    #    format.json { render action: 'show', status: :created, location: @opportunity }
    #  else
    #    format.html { render action: 'new' }
    #    format.json { render json: @opportunity.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /opportunities/1
  # PATCH/PUT /opportunities/1.json
  def update
    forbidden unless current_account_user.update_opportunity
    if @opportunity.update(opportunity_params)
      flash[:info]      = { title: "Success", body: "Opportunity Updated" }
      redirect_to account_account_opportunity_path(@account, @opportunity)
    else
      flash[:danger]      = { title: "Error", body: "Unable to update opportunity" }
      redirect_to edit_new_account_account_opportunity_path(@account)
    end
    #respond_to do |format|
    #  if @opportunity.update(opportunity_params)
    #    format.html { redirect_to @opportunity, notice: 'Opportunity was successfully updated.' }
    #    format.json { head :no_content }
    #  else
    #    format.html { render action: 'edit' }
    #    format.json { render json: @opportunity.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /opportunities/1
  # DELETE /opportunities/1.json
  def destroy
    forbidden unless current_account_user.delete_opportunity
    @opportunity.destroy
    redirect_to account_account_opportunities_path(@account)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opportunity
      @opportunity = Opportunity.cached_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opportunity_params
      params.require(:opportunity).permit(:title, :body, :kind, :budget, :deadline, :account_id)
    end
end