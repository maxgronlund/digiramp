class Admin::ProAffiliationsController < ApplicationController
  before_action :set_pro_affiliation, only: [:show, :edit, :update, :destroy]
  before_action :admins_only
  

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


  def create
    @pro_affiliation = ProAffiliation.new(pro_affiliation_params)
    Admin.cached_find(1).pro_affilications_uuid =

    if @pro_affiliation.save
      redirect_to admin_pro_affiliation_path
    else
      redirect_to :back
    end
  end


  def update
    if @pro_affiliation.update_attributes(pro_affiliation_params)
      redirect_to admin_pro_affiliation_path
    else
      redirect_to :back
    end
  end

  # DELETE /pro_affiliations/1
  # DELETE /pro_affiliations/1.json
  def destroy
    @pro_affiliation.destroy
    redirect_to admin_pro_affiliation_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pro_affiliation
      @pro_affiliation = ProAffiliation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pro_affiliation_params
      params.require(:pro_affiliation).permit!
    end
end
