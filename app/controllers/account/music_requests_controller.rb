class Account::MusicRequestsController < ApplicationController
  before_action :set_music_request, only: [:show, :edit, :update, :destroy]
  
  include AccountsHelper
  before_filter :access_account

  # GET /oppertunities
  # GET /oppertunities.json
  def index
    forbidden unless current_account_user.read_oppertunity
    #@oppertunities = Oppertunity.all
  end

  # GET /oppertunities/1
  # GET /oppertunities/1.json
  def show
    forbidden unless current_account_user.read_oppertunity
  end

  # GET /oppertunities/new
  def new
    forbidden unless current_account_user.create_oppertunity
    @oppertunity = Oppertunity.new
  end

  # GET /oppertunities/1/edit
  def edit
    forbidden unless current_account_user.update_oppertunity
  end

  # POST /oppertunities
  # POST /oppertunities.json
  def create
    forbidden unless current_account_user.create_oppertunity
    @oppertunity = Oppertunity.new(oppertunity_params)
    
    if @oppertunity.save
      flash[:info]      = { title: "Success", body: "Oppertunity Created" }
      redirect_to account_account_oppertunity_path(@account, @oppertunity)
       
    else
      flash[:danger]      = { title: "Error", body: "Unable to create oppertunity" }
      redirect_to new_account_account_oppertunity_path(@account)
    end

  end

  # PATCH/PUT /oppertunities/1
  # PATCH/PUT /oppertunities/1.json
  def update
    forbidden unless current_account_user.update_oppertunity
    if @oppertunity.update(oppertunity_params)
      flash[:info]      = { title: "Success", body: "Oppertunity Updated" }
      redirect_to account_account_oppertunity_path(@account, @oppertunity)
    else
      flash[:danger]      = { title: "Error", body: "Unable to update oppertunity" }
      redirect_to edit_new_account_account_oppertunity_path(@account)
    end
    #respond_to do |format|
    #  if @oppertunity.update(oppertunity_params)
    #    format.html { redirect_to @oppertunity, notice: 'Oppertunity was successfully updated.' }
    #    format.json { head :no_content }
    #  else
    #    format.html { render action: 'edit' }
    #    format.json { render json: @oppertunity.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /oppertunities/1
  # DELETE /oppertunities/1.json
  def destroy
    forbidden unless current_account_user.delete_oppertunity
    @oppertunity.destroy
    redirect_to account_account_oppertunities_path(@account)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_music_request
      @music_request = MusicRequest.cached_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def oppertunity_params
      params.require(:oppertunity).permit(:title, :body, :kind, :budget, :deadline, :account_id)
    end
end
