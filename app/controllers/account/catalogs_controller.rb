class Account::CatalogsController < ApplicationController
  
  include AccountsHelper
  include CatalogsHelper
  
  before_action :access_account
  before_action :access_catalog, only: [:show, 
                                        :update, 
                                        :edit, 
                                        :move, 
                                        :copy_code, 
                                        :find_common_work_in_collection
                                        
                                       ]

  
 
  
  def index

    #forbidden unless current_user && current_user.has_access_to_cattalogs_on( @account )
    @user = current_user
    @authorized = true
    

  end

  def show

  end

  def new
    forbidden unless current_account_user && current_account_user.createx_catalog
    @catalog = Catalog.new
  end
  
  def create

  end

  def edit
    #@catalog = Catalog.cached_find(params[:id])
  end
  
  def update

  end
  
  def move
    #forbidden unless  current_user.can_administrate @account
  end
  

  
  def generate_code
    #@catalog            = Catalog.cached_find(params[:catalog_id])
    #
    #if params[:catalog][:movable] == '1'
    #  if @catalog.move_code.to_s == ''
    #    @catalog.move_code  = UUIDTools::UUID.timestamp_create().to_s
    #  end
    #  @catalog.movable      = true
    #  @catalog.include_all  = params[:catalog][:include_all] == '1'
    #  @catalog.save!
    #  redirect_to :back
    #else
    #  @catalog.move_code    = ''
    #  @catalog.movable      = false
    #  @catalog.include_all  = false
    #  @catalog.save!
    #  redirect_to catalog_account_catalog_path( @account, @catalog) 
    #end
    
  end
  

  def destroy
    @catalog = Catalog.find(params[:id])
    @catalog_id = @catalog.id
    @catalog.destroy
    redirect_to account_account_catalogs_path( @account)
  end
  
private

  def catalog_params
    params.require(:catalog).permit!
  end
  
  
end
