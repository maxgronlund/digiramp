class Account::RecordingLyricsController < ApplicationController

  include RecordingsHelper
  include AccountsHelper
  before_action :access_account
  before_action :read_recording, only:[ :edit, :update]
  
  def edit
    forbidden unless current_account_user.update_recording?
  end
  


  def update

    forbidden unless current_account_user.update_recording?
    go_to = params[:recording][:next_step]
    params[:recording].delete :next_step
    
    @recording.update_attributes(recording_params)
    
    if go_to == 'next_step'
      redirect_to edit_account_account_recording_tag_path(@account, @recording)
    else
      redirect_to account_account_recording_path( @account, @recording )
    end
    
    
  end
  
private

  def recording_params
    params.require(:recording).permit!
  end
end
