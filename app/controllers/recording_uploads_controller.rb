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
        
                  
        #current_user.create_activity(  :created, 
        #                           owner: recording,
        #                       recipient: @user,
        #                  recipient_type: 'Recording',
        #                      account_id: current_user.account.id) 
        #                      
        #
        #common_work = CommonWork.create(account_id: recording.account_id, 
        #                                title: recording.title, 
        #                                lyrics: recording.lyrics)
        #
        #           
        #recording.common_work_id = common_work.id
        #recording.title = title unless title == 'no title'
        #recording.save
        #recording.common_work.update_completeness
        #recording.title = File.basename(recording.original_file_name, ".*") 
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
