class RecordingUploadsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  before_action :get_user, only: [ :edit, :update]
  def edit
    
    @user           = User.cached_find(params[:user_id])
    @recording      = Recording.cached_find(params[:id])
    
    forbidden unless current_user
    unless current_user.super?
      forbidden unless @recording.user_id == current_user.id
    end
    
  end

  def update
    
    result = TransloaditRecordingsParser.update params[:transloadit], params[:id]
    #result = TransloaditRecordingsParser.parse( params[:transloadit],  @user.account.id, false, @user.id)

    title = params[:recording][:title]

    
    if result[:recordings].size != 0
      
      result[:recordings].each do |recording|
        @recording = recording
      end
      redirect_to edit_user_recording_basic_path(@user, @recording)
    else
      flash[:danger]      = "Please check it's a real audio file you are uploading"
      redirect_to new_user_recording_path(@user)
    end
    
    
  end
  
  

  
private

  def recording_params
    params.require(:recording).permit( RecordingParams::PARAMS )
  end
end
