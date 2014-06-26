class Account::CommonWorksImportsController < ApplicationController
  
  include AccountsHelper

  
  before_filter :access_account

                                       
                                       
  def index
    
  end


  def show
    @common_work_import = CommonWorksImport.cached_find(params[:id])
  end
  
private

  # Never trust parameters from the scary internet, only allow the white list through.
  def common_work_import_params
    params.require(:common_works_import).permit!
  end
end
