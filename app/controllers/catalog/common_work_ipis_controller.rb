class Catalog::CommonWorkIpisController < ApplicationController
  
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  include CatalogsHelper
  include ActionView::Helpers::TextHelper
  
  before_filter :access_account
  before_filter :access_catalog
  
  before_filter :authorize_common_work
  before_action :common_work_ipi_params, only: :update
                                        
  def index
    forbidden unless current_catalog_user.read_common_work_ipi?
   
  end

  def show
  end
  
  def new
    forbidden unless current_catalog_user.update_common_work_ipi?
    @common_work_ip = Ipi.new
  end
  
  def edit
    forbidden unless current_catalog_user.update_common_work_ipi?
    @common_work_ip     = Ipi.cached_find(params[:id])

    @common_work_ip
    #redirect_to edit_catalog_account_catalog_common_work_common_work_ipi_path(@account, @catalog, @common_work, @common_work_ip)
  end

  def destroy
    @common_work_ip     = Ipi.cached_find(params[:id])
    @common_work_ip.destroy!
    redirect_to catalog_account_catalog_common_work_common_work_ipis_path(@account, @catalog, @common_work)
    
  end
  
  def update
    ipi = Ipi.cached_find(params[:id])
    ipi.update_attributes(params[:ipi]) if ipi.present?
    ap ipi
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def authorize_common_work
       @common_work = CommonWork.cached_find(params[:common_work_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def common_work_ipi_params
    #   params.require(:common_work_ipi).permit!
    # end
    def common_work_ipi_params
      params.require(:ipi).permit!
    end
end
