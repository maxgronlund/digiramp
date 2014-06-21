require 'pusher'











class Catalog::CatalogsController < ApplicationController
  
  include AccountsHelper
  include CatalogsHelper
  
  before_filter :access_account
  before_filter :access_catalog, only: [:show, 
                                        :update, 
                                        :edit, 
                                        :move, 
                                        :copy_code, 
                                        :find_common_work_in_collection
                                       ]
  #before_filter :current_account_user
  
  def index
    forbidden unless current_account_user.read_catalog
    puts '--------------------- INDEX ------------------------'
    #@catalogs     = @account.catalogs
    Pusher.trigger('my-channel', 'digiramp-event', {:message => 'hello world max'})
    
    data = {'message' => 'This is an HTML5 Realtime Push Notification!'}
    Pusher['my_notifications'].trigger('notification', data)
    
  end

  def show
    puts '--------------------- SHOW ------------------------'
  end

  def new
    forbidden unless current_account_user.create_catalog
    @catalog = Catalog.new
  end
  
  def create
    @catalog = Catalog.create(catalog_params)
    flash[:info] = { title: "SUCCESS: ", body: "Catalog created" }
    redirect_to catalog_account_catalog_path( @account, @catalog)
  end

  def edit
    @catalog = Catalog.cached_find(params[:id])
  end
  
  def update
    #@catalog = Catalog.cached_find(params[:id])
    @catalog.update_attributes(catalog_params)
    flash[:info] = { title: "SUCCESS: ", body: "Catalog updated" }
    redirect_to catalog_account_catalog_path( @account, @catalog)
  end
  
  def move
    forbidden unless  current_user.can_administrate @account
  end
  
  def find_common_work_in_collection
    forbidden unless current_account_user.read_common_work?
    
    @common_works  = CommonWork.find_from_collection(@account, @catalog, params[:query]).order('title asc').page(params[:page]).per(32)
    #@common_works  = CommonWork.catalog_search(@catalog, params[:query]).order('title asc').page(params[:page]).per(32)
  end
  
  #def move
  #  @catalog = Catalog.cached_find(params[:catalog_id])
  #end
  
  #def receive
  #  @catalog = Catalog.cached_find(params[:catalog_id])
  #end
  
  
  #def get_catalog
  #  @catalog = Catalog.new
  #end
  
  #def receive
  #  
  #  @catalog      = Catalog.where(move_code: params[:catalog][:move_code]).first
  #
  #  if @catalog
  #    MoveCatalog.move_to_account @catalog, @account
  #    @catalog.move_code  = ''
  #    @catalog.movable    = false
  #    @catalog.save!
  #    flash[:info] = { title: "SUCCESS: ", body: "Catalog received" }
  #    redirect_to account_catalog_path( @account, @catalog )
  #  else
  #    flash[:danger] = { title: "ERROR: ", body: "No catalog found" }
  #    redirect_to account_catalog_get_catalog_path(@account, 1)
  #  end
  #end
  
  
  #def confirm
  #  @catalog = Catalog.cached_find(params[:catalog_id])
  #  @catalog.move_code = UUIDTools::UUID.timestamp_create().to_s
  #  @catalog.save!
  #  redirect_to account_catalog_move_path @account, @catalog
  #end
  
  def generate_code
    @catalog            = Catalog.cached_find(params[:catalog_id])
    
    if params[:catalog][:movable] == '1'
      if @catalog.move_code.to_s == ''
        @catalog.move_code  = UUIDTools::UUID.timestamp_create().to_s
      end
      @catalog.movable      = true
      @catalog.include_all  = params[:catalog][:include_all] == '1'
      @catalog.save!
      redirect_to :back
    else
      @catalog.move_code    = ''
      @catalog.movable      = false
      @catalog.include_all  = false
      @catalog.save!
      redirect_to catalog_account_catalog_path( @account, @catalog) 
    end
    
  end
  
  #def get_code
  #  @catalog            = Catalog.cached_find(params[:catalog_id])
  #  @catalog.move_code  = UUIDTools::UUID.timestamp_create().to_s
  #  @catalog.movable    = true
  #  @catalog.save!
  #  redirect_to account_catalog_move_path @account, @catalog
  #end
  
  def destroy
    @catalog = Catalog.find(params[:id])
    @catalog.destroy
    redirect_to catalog_account_catalogs_path( @account)
  end
  
private

  def catalog_params
    params.require(:catalog).permit!
  end
  
  
end
