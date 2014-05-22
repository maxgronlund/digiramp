class Admin::ProAffiliationsController < ApplicationController
  before_action :set_pro_affiliation, only: [:show, :edit, :update, :destroy]
  before_filter :admins_only
  

  def index
    @pro_affiliations = ProAffiliation.all
  end


  def show
  end

  # GET /pro_affiliations/new
  def new
    @pro_affiliation = ProAffiliation.new
  end

  # GET /pro_affiliations/1/edit
  def edit
  end

  # POST /pro_affiliations
  # POST /pro_affiliations.json
  def create
    @pro_affiliation = ProAffiliation.new(pro_affiliation_params)
    Admin.cached_find(1).pro_affilications_uuid =
    respond_to do |format|
      if @pro_affiliation.save
        format.html { redirect_to @pro_affiliation, notice: 'Pro affiliation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pro_affiliation }
      else
        format.html { render action: 'new' }
        format.json { render json: @pro_affiliation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pro_affiliations/1
  # PATCH/PUT /pro_affiliations/1.json
  def update
    respond_to do |format|
      if @pro_affiliation.update(pro_affiliation_params)
        format.html { redirect_to @pro_affiliation, notice: 'Pro affiliation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pro_affiliation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pro_affiliations/1
  # DELETE /pro_affiliations/1.json
  def destroy
    @pro_affiliation.destroy
    respond_to do |format|
      format.html { redirect_to pro_affiliations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pro_affiliation
      @pro_affiliation = ProAffiliation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pro_affiliation_params
      params.require(:pro_affiliation).permit(:country, :web, :title)
    end
end
