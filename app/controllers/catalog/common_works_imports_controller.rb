class Catalog::CommonWorksImportsController < ApplicationController
  
  include AccountsHelper
  include CatalogsHelper
  
  before_filter :access_account
  before_filter :access_catalog
                                       
                                       
  def new
  end
  
  def create
    
    CommonWorksImport.post_info current_user.email, info = {start: 'starting'}

    AscapScraperWorker.perform_async( params[:common_works_import][:user_name], 
                                      params[:common_works_import][:password],
                                      params[:common_works_import][:account_id],
                                      params[:common_works_import][:catalog_id],
                                      params[:common_works_import][:title],
                                      params[:common_works_import][:body],
                                      params[:common_works_import][:pro],
                                      params[:common_works_import][:user_email]
                                    )
    
    
    #http://localhost:3000/catalog/accounts/6/catalogs/53/common_works_imports/new
    redirect_to catalog_account_catalog_common_works_import_path(@account, @catalog, 1)
  end

  def select_pro
  end

  def from_ascap
  end

  def from_bmi
  end

  def show
  end
  
private

  # Never trust parameters from the scary internet, only allow the white list through.
  #def artwork_params
  #  params.require(:artwork).permit!
  #end
end
