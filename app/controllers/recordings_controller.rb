class RecordingsController < ApplicationController
  before_filter :get_user, only: [:show, :index, :edit, :update, :new]
  def index
    @widget = @user.default_widget
    if @authorized  
      @recordings =   Recording.recordings_search(@user.recordings, params[:query]).page(params[:page]).per(48)
    else
      @recordings =  @user.recordings.published.recordings_search(@user.recordings, params[:query]).page(params[:page]).per(48)
    end

  end
  
  def new
    @recording = Recording.new
  end
  
  def show
    @recording = Recording.find(params[:id])
    #@widget = @user.default_widget
    #@recordings = @widget.recordings
  end
  
  def destroy
    @recording = Recording.find(params[:id])
    common_work = @recording.common_work
    @recording.destroy
    common_work.update_completeness

    redirect_to :back
  end
  
  def edit
    @recording = Recording.cached_find(params[:id])
    
    
  end
  
  def update
    @recording      = Recording.find(params[:id])
    

    if @recording.update_attributes(recording_params)
       @recording.extract_genres
       @recording.extract_instruments
       @recording.extract_moods
       
    end
    redirect_to user_recording_path( @user, @recording )
  end
   
private

  def recording_params
    params.require(:recording).permit!
  end
end
