class RecordingTagsController < ApplicationController
  
  before_action :get_user, only: [ :edit, :update]
  include RecordingsHelper
  before_action :update_user_recording, only: [ :edit, :update]
  
  def edit
    
    not_found( params ) unless @recording
  end

  def update
    #go_to = params[:recording][:next_step]
    #params[:recording].delete :next_step

    @recording.update_attributes(recording_params)
    @recording.extract_genres
    @recording.extract_instruments
    @recording.extract_moods
    @recording.save!
    
    #redirect_to edit_user_recording_social_path( @user, @recording )
    redirect_to user_recording_path( @recording.user, @recording )
    
    
    
    
  end
  
private

  def recording_params
    params.require(:recording).permit( RecordingParams::PARAMS )
  end
end
