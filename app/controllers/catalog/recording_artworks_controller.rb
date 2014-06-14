class Catalog::RecordingArtworksController < ApplicationController
  include AccountsHelper
  include CatalogsHelper
  
  before_filter :access_account
  before_filter :access_catalog, only: [:index]

  def index
    forbidden unless current_catalog_user.read_file
    @recording      = Recording.find(params[:recording_id])

    #access = false
    #
    #if current_user.can_administrate @account
    #  access = true
    #elsif @common_work.is_accessible_by current_user
    #  access = true
    #end
    #
    #unless access
    #  render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
    #end
  end
  
  #def edit
  #  redirect_to :back
  #end
  #
  #def update
  #  
  #end
  #
  #def destroy
  #  @image_files   = ImageFile.find(params[:id])
  #  #@common_work    = CommonWork.find(params[:common_work_id])
  #  #@recording      = Recording.find(params[:id])
  #  redirect_to :back
  #end
end
