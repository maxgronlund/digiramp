class Account::OpportunityInvitationsController < ApplicationController
  before_action :set_opportunity_invitation, only: [:show, :edit, :update, :destroy]
  include AccountsHelper
  before_filter :access_account

  # GET /opportunity_invitations
  # GET /opportunity_invitations.json
  #def index
  #  @opportunity_invitations = OpportunityInvitation.all
  #end
  #
  ## GET /opportunity_invitations/1
  ## GET /opportunity_invitations/1.json
  #def show
  #end

  # GET /opportunity_invitations/new
  def new
    @opportunity            = Opportunity.cached_find(params[:opportunity_id])
    @opportunity_invitation = OpportunityInvitation.new
  end

  # GET /opportunity_invitations/1/edit
  def edit
    @opportunity            = Opportunity.cached_find(params[:opportunity_id])
  end

  # POST /opportunity_invitations
  # POST /opportunity_invitations.json
  def create
    @opportunity            = Opportunity.cached_find(params[:opportunity_id])
    @opportunity_invitation = OpportunityInvitation.create(opportunity_invitation_params)
     redirect_to account_account_opportunity_path(@account, @opportunity)
    #respond_to do |format|
    #  if @opportunity_invitation.save
    #    format.html { redirect_to @opportunity_invitation, notice: 'Opportunity invitation was successfully created.' }
    #    format.json { render :show, status: :created, location: @opportunity_invitation }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @opportunity_invitation.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /opportunity_invitations/1
  # PATCH/PUT /opportunity_invitations/1.json
  def update
    @opportunity            = Opportunity.cached_find(params[:opportunity_id])
    @opportunity_invitation.update(opportunity_invitation_params)
     redirect_to account_account_opportunity_path(@account, @opportunity)
  end

  # DELETE /opportunity_invitations/1
  # DELETE /opportunity_invitations/1.json
  def destroy
    @opportunity            = Opportunity.cached_find(params[:opportunity_id])
    @opportunity_invitation.destroy
     redirect_to account_account_opportunity_path(@account, @opportunity)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opportunity_invitation
      @opportunity_invitation = OpportunityInvitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opportunity_invitation_params
      params.require(:opportunity_invitation).permit!
    end
end