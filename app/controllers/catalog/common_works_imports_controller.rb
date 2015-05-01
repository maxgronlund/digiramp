class Catalog::CommonWorksImportsController < ApplicationController
  
  include AccountsHelper
  include CatalogsHelper
  
  before_action :access_account
  before_action :access_catalog
                                       
                                       
  def new
    @user = current_user
  end
  
  def create

    @common_work_import = CommonWorksImport.create(common_work_import_params)
    
    #CommonWorksImport.post_info current_user.email, info = {start: 'starting'}
    #
    #AscapScraperWorker.perform_async( params[:common_works_import][:user_name], 
    #                                  params[:common_works_import][:password],
    #                                  params[:common_works_import][:account_id],
    #                                  params[:common_works_import][:catalog_id],
    #                                  params[:common_works_import][:title],
    #                                  params[:common_works_import][:body],
    #                                  params[:common_works_import][:pro],
    #                                  params[:common_works_import][:user_email]
    #                                )
    #
    #
    #http://localhost:3000/catalog/accounts/6/catalogs/53/common_works_imports/new
    #redirect_to catalog_account_catalog_common_works_import_path(@account, @catalog, 1)
    
    case @common_work_import.pro
      
    when 'ASCAP'
      redirect_to catalog_account_catalog_common_works_import_from_ascap_path( @account, @catalog, @common_work_import)
    when 'BMI'
      redirect_to catalog_account_catalog_common_works_import_from_bmi_path( @account, @catalog, @common_work_import)
    end
  end

  def select_pro
    @user               = current_user
  end

  def from_ascap
    @user               = current_user
    @common_work_import = CommonWorksImport.cached_find(params[:common_works_import_id])
    
  end
  
  def ascap_import
    @common_work_import = CommonWorksImport.cached_find(params[:common_works_import_id])
    @common_work_import.update_attributes!(common_work_import_params)
    
    CommonWorksImport.post_info current_user.email, info = {start: :ascap_import}
    
    #AscapScraperWorker.perform_async( params[:common_works_import][:user_name], 
    #                                  params[:common_works_import][:password],
    #                                  @common_work_import.id
    #                                )
    #
    AscapScraperJob.perform_later( params[:common_works_import][:user_name], 
                                    params[:common_works_import][:password],
                                    @common_work_import.id
                                  )
    
    

    redirect_to catalog_account_catalog_common_works_import_path(@account, @catalog, @common_work_import)
    
   
  end

  def from_bmi
    @user               = current_user
    @common_work_import = CommonWorksImport.cached_find(params[:common_works_import_id])
  end
  
  def bmi_import
    @common_work_import = CommonWorksImport.cached_find(params[:common_works_import_id])
    if @common_work_import.update_attributes!(common_work_import_params)
    
      BmiScraperWorker.perform_async( params[:common_works_import][:user_name], 
                                        params[:common_works_import][:password],
                                        @common_work_import.id
                                      )
                                      #info[:start] == :bmi_import
      
    end

    redirect_to catalog_account_catalog_common_works_import_path(@account, @catalog, @common_work_import)
    
   
  end

  def show
    @user               = current_user
    @common_work_import = CommonWorksImport.cached_find(params[:id])
    
  end
  
private

  # Never trust parameters from the scary internet, only allow the white list through.
  def common_work_import_params
    params.require(:common_works_import).permit!
  end
end
