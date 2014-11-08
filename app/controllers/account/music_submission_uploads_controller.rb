class Account::MusicSubmissionUploadsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  
  
  
  def new
    @recording      = Recording.new
    @user           = current_user
    @music_request  = MusicRequest.cached_find(params[:music_request_id])
    
  end

  def create
    puts '==============================================================='
    ap params[:music_request_id]
    ap params[:recording]
    puts '==============================================================='
    #ap params
    
    @music_request           = MusicRequest.cached_find(params[:music_request_id])
    
    @user = current_user
    
    result = TransloaditRecordingsParser.parse( params[:transloadit],  @user.account_id, false, @user.id)
    title = params[:recording][:title]

    if result[:recordings].size != 0
      
      result[:recordings].each do |recording|
        
                  
        current_user.create_activity(  :created, 
                                   owner: recording,
                               recipient: @user,
                          recipient_type: 'Recording',
                              account_id: current_user.account_id) 
                              
        
        common_work = CommonWork.create(account_id: recording.account_id, 
                                        title: recording.title, 
                                        lyrics: recording.lyrics)
        
                   
        recording.common_work_id = common_work.id
        recording.title = title unless title == 'no title'
        recording.save
        recording.common_work.update_completeness
        @recording = recording
        
        
        
        music_submission = MusicSubmission.create(  recording_id:          recording.id,
                                                 music_request_id:      @music_request.id,
                                                 user_id:               current_user.id,
                                                 title:                 recording.title,
                                                 account_id:            @music_request.opportunity.account_id,
                                                 opportunity_user_id:   current_user.id
                                                )
                              
                       
        
        
        flash[:info]      = { title: "Recording Submitted", body: "You can now fill in additional informations or go back to the opportunity" } 
      end
      redirect_to edit_user_recording_basic_path(@user, @recording)
    else
      flash[:danger]      = { title: "Unknown fileformat", body: "Please check it's a real audio file you are uploading" }
      redirect_to new_user_recording_path(@user)
    end
  end
end
