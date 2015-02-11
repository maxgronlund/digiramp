class User::WorkRightsController < ApplicationController
  before_filter :access_user
  #include AccountsHelper
  
  def index
    @recording    = Recording.cached_find(params[:recording_id])
    @common_work  = @recording.common_work
    
    if params[:go_to]
      @go_to = params[:go_to]
    else
      @go_to = 'who_wrote_the_music'
    end
  end

  def show
  end

  def new
  end

  def edit
  end

  def update
  end

  def delete
  end
end
