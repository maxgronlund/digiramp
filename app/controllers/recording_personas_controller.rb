class RecordingPersonasController < ApplicationController

  before_filter :get_user, only: [ :edit, :update]
  include RecordingsHelper
  before_filter :update_user_recording, only: [ :edit, :update]

  def edit
    not_found( params ) unless @recording
  end
  
  def update
    if params[:recording]
      @recording.update_attributes(recording_params) 
      @recording.confirm_ipis
    end
    
    if params[:commit] == 'Save'
      redirect_to edit_user_recording_right_path(@recording.user, @recording)
    else
      redirect_to user_recording_path( @recording.user, @recording )
    end

  end
  
  
private

  def recording_params
    params.require(:recording).permit!
  end
end
