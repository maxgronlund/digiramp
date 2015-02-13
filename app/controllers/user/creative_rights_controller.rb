class User::CreativeRightsController < ApplicationController
  
  
  before_filter :access_user
  
  
  def index

    #@recordings = @user.recordings.order(:title)
    if params[:commit] == 'Go' || params[:commit].nil?
      @remove_old_recordings = true
      session[:query] = params[:query]
    end
    
    session[:query] = nil if params[:clear] == 'clear'
    params[:query]  = session[:query]
    @recordings =  Recording.recordings_search(@user.recordings, params[:query]).order('position desc').page(params[:page]).per(48)
    #
    #
    #
    #if current_user && current_user.id == @user.id
    #  @recordings =  Recording.recordings_search(@user.recordings, params[:query]).order('position desc').page(params[:page]).per(4)
    #else
    #  @recordings =  Recording.public_access.recordings_search(@user.recordings, params[:query]).order('position desc').page(params[:page]).per(4)
    #end
  end

  def show
    @recording   = Recording.cached_find(params[:recording_id])
    @common_work = @recording.common_work
  end

  def edit
  end

  def update
  end
end
