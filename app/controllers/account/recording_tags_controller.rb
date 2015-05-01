class Account::RecordingTagsController < ApplicationController
  
  include RecordingsHelper
  include AccountsHelper
  before_action :access_account
  before_action :read_recording, only:[ :edit, :update]
  
  def edit
    forbidden unless current_account_user.update_recording?
  end
  

  def update
    go_to = params[:recording][:next_step]
    params[:recording].delete :next_step
    
    #@recording      = Recording.cached_find(params[:id])
    #@account        = Account.cached_find(params[:account_id])

    @recording.update_attributes(recording_params)
    @recording.extract_genres
    @recording.extract_instruments
    @recording.extract_moods
    @recording.save!
    
    redirect_to account_account_recording_path( @account, @recording )
    
    #if go_to == 'next_step'
    #  redirect_to edit_user_recording_persona_path(@recording.user, @recording)
    #else
    #  redirect_to user_recording_path( @recording.user, @recording )
    #end
    
    
    
  end
  
private

  def recording_params
    params.require(:recording).permit!
  end
end
