class Catalog::CommonWorkIpisController < ApplicationController
  
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  include CatalogsHelper
  include ActionView::Helpers::TextHelper
  
  before_filter :access_account
  before_filter :access_catalog
                                        
                                        
                                        
  def index
    forbidden unless current_catalog_user.read_common_work_ipi?
    @common_work = CommonWork.cached_find(params[:common_work_id])
  end

  def show
  end

  def edit
  end

  def update
  end
end
