class Account::OppertunitiesController < ApplicationController
  before_action :set_oppertunity, only: [:show, :edit, :update, :destroy]
  
  include AccountsHelper
  before_filter :access_account

  # GET /oppertunities
  # GET /oppertunities.json
  def index
    @oppertunities = Oppertunity.all
  end

  # GET /oppertunities/1
  # GET /oppertunities/1.json
  def show
  end

  # GET /oppertunities/new
  def new
    @oppertunity = Oppertunity.new
  end

  # GET /oppertunities/1/edit
  def edit
  end

  # POST /oppertunities
  # POST /oppertunities.json
  def create
    @oppertunity = Oppertunity.new(oppertunity_params)
    
    if @oppertunity.save
      redirect_to account_account_oppertunity_path(@account, @oppertunity)
    else
      redirect_to new_account_account_oppertunity_path(@account)
    end

    #respond_to do |format|
    #  if @oppertunity.save
    #    format.html { redirect_to @oppertunity, notice: 'Oppertunity was successfully created.' }
    #    format.json { render action: 'show', status: :created, location: @oppertunity }
    #  else
    #    format.html { render action: 'new' }
    #    format.json { render json: @oppertunity.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /oppertunities/1
  # PATCH/PUT /oppertunities/1.json
  def update
    respond_to do |format|
      if @oppertunity.update(oppertunity_params)
        format.html { redirect_to @oppertunity, notice: 'Oppertunity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @oppertunity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /oppertunities/1
  # DELETE /oppertunities/1.json
  def destroy
    @oppertunity.destroy
    respond_to do |format|
      format.html { redirect_to oppertunities_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_oppertunity
      @oppertunity = Oppertunity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def oppertunity_params
      params.require(:oppertunity).permit(:title, :body, :kind, :budget, :deadline, :account_id)
    end
end
