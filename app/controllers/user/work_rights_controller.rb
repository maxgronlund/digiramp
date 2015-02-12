class User::WorkRightsController < ApplicationController
  before_filter :access_user
  #include AccountsHelper
  
  NEXT_STEP = { arrangement_true: 'arrangers',
                arrangement_false: 'writers',
              }
  
  def index
    @recording    = Recording.cached_find(params[:recording_id])
    @common_work  = @recording.common_work
    
    if params[:go_to]
      @go_to = params[:go_to]
    else
      @go_to = 'work_informations'
    end
  end

  def show
  end

  #def new
  #end
  #
  #def create
  #  
  #end

  #def edit
  #end

  def update
    @recording    = Recording.cached_find(params[:recording_id])
    @common_work  = @recording.common_work
    #ap params
    #ap params[:value] == 'true'

    case params[:step]
      
    when 'arrangement'
      if params[:value] == 'true'
        @common_work.arrangement = true
        @go_to = NEXT_STEP[:arrangement_true] 
      else
        @common_work.arrangement = false
        @go_to = NEXT_STEP[:arrangement_false] 
      end
    end
    @common_work.save!
    ap @common_work
  end

  def delete
  end
end
  
  
