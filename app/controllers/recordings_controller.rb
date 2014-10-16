class RecordingsController < ApplicationController
  before_filter :get_user, only: [:show, :index, :edit, :update, :new, :create, :destroy]
  include Transloadit::Rails::ParamsDecoder
  
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
  
  def create
    
    result = TransloaditRecordingsParser.parse( params[:transloadit],  @user.account_id, false)
    if result[:recordings].size != 0
      
      result[:recordings].each do |recording|
        
        #recording.create_activity(  :created, 
        #                          owner: current_user,
        #                      recipient: recording,
        #                 recipient_type: recording.class.name,
        #                     account_id: @user.account_id)
        #                     
        #                     
        current_user.create_activity(  :created, 
                                   owner: recording,
                               recipient: @user,
                          recipient_type: 'Recording',
                              account_id: current_user.account_id) 
                              
        
        common_work = CommonWork.create(account_id: recording.account_id, 
                                        title: recording.title, 
                                        lyrics: recording.lyrics)
        
        
        #common_work.create_activity(  :created, 
        #                          owner: current_user,
        #                      recipient: common_work,
        #                 recipient_type: common_work.class.name,
        #                     account_id: @user.account_id)
        #                     
        #                     
        recording.common_work_id = common_work.id
        recording.save
        recording.common_work.update_completeness
        @recording = recording

      end
      redirect_to edit_user_recording_path(@user, @recording)
    else
      flash[:error]      = { title: "Error", body: "Unable to upload recording" }
      render new
    end
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
    common_work.update_completeness if common_work

    redirect_to user_recordings_path(@user)
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
