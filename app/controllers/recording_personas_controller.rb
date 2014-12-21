class RecordingPersonasController < ApplicationController
  #include AccountsHelper
  #before_filter :access_account, only: [:show]
  #before_filter :get_user, only: [ :edit, :update]
  before_filter :get_user, only: [:show, :edit, :update]

  def show
    @common_work    = CommonWork.cached_find(params[:common_work_id])
    @recording      = Recording.cached_find(params[:id])
  end
  
  def edit
    @recording      = Recording.cached_find(params[:id])
    @user           = User.cached_find(params[:user_id])
    
  end
  
  def update
    #go_to = params[:recording][:next_step]
    #params[:recording].delete :next_step
    
    @recording      = Recording.cached_find(params[:id])
    @recording.update_attributes(recording_params)
    
    @recording.confirm_ipis
    
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
