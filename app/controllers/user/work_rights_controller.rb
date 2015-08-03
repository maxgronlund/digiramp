class User::WorkRightsController < ApplicationController
  before_action :access_user
  #include AccountsHelper
  
  NEXT_STEP = { arrangement_true: 'arrangers',
                arrangement_false: 'writers',
              }
  
  def index
    @recording    = Recording.cached_find(params[:recording_id])
    @common_work  = @recording.common_work
    
    #if params[:go_to]
    #  @go_to = params[:go_to]
    #else
    #  @go_to = 'work_informations'
    #end
  end

  def show
  end

  
private
  #def common_work_params
  #  params.require(:common_work).permit!
  #end
end
  
  
