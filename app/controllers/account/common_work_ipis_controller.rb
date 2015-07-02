class Account::CommonWorkIpisController < ApplicationController
  
  #include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  #include ActionView::Helpers::TextHelper
  
  before_action :access_account

  
  before_action :get_common_work
                                        
                                        
                                        
  def index
    forbidden unless current_account_user && current_account_user.read_common_work_ipi?
   
  end

  def show
  end
  
  def new
    forbidden unless current_account_user && current_account_user.update_common_work_ipi?
    @common_work_ip = Ipi.new
  end
  
  def create
    forbidden unless current_account_user && current_account_user.create_common_work_ipi?
    @ipi = Ipi.create(ipi_params)
    redirect_to account_account_common_work_common_work_ipis_path(@account, @common_work)
  end
  
  def update
    forbidden unless current_account_user && current_account_user.update_common_work_ipi?
    @ipi = Ipi.cached_find(params[:id])
    @ipi.update_attributes(ipi_params)
    redirect_to account_account_common_work_common_work_ipis_path(@account, @common_work)
  end
  
  

  def edit
    forbidden unless current_account_user && current_account_user.update_common_work_ipi?
    @common_work_ip     = Ipi.cached_find(params[:id])
    @common_work_ip
    #redirect_to edit_catalog_account_catalog_common_work_common_work_ipi_path(@account, @catalog, @common_work, @common_work_ip)
  end

  def destroy
    @common_work_ip     = Ipi.cached_find(params[:id])
    @common_work_ip.destroy!
    redirect_to account_account_common_work_common_work_ipis_path(@account, @common_work)
    
  end
  
  
  
private
  # Use callbacks to share common setup or constraints between actions.
  def get_common_work
     @common_work = CommonWork.cached_find(params[:common_work_id])
  end
  
  def ipi_params
     params.require(:ipi).permit!
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # def common_work_ipi_params
  #   params.require(:common_work_ipi).permit!
  # end
end
