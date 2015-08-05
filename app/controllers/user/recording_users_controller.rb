class User::RecordingUsersController < ApplicationController
  before_action :set_recording, only: [:index, :create,  :destroy]

  before_action :access_user

  # GET /recording_users
  # GET /recording_users.json
  def index
    @recording_users = @recording.recording_users.all
    @recording_user  = RecordingUser.new
  end

  # POST /recording_users
  # POST /recording_users.json
  def create

    @recording      = Recording.cached_find(params[:recording_id])
    @user           = @recording.user
    @recording_user = RecordingUser.new(recording_user_params)
    
    if @recording_user.save
      redirect_to user_user_recording_recording_users_path(@user, @recording)
    else
      render :index 
    end
    
  end
  

  # DELETE /recording_users/1
  # DELETE /recording_users/1.json
  def destroy
    
    @recording_user = RecordingUser.cached_find(params[:id])
    @recording_user.destroy
    respond_to do |format|
      format.html { redirect_to user_user_recording_recording_users_path(@recording.user, @recording) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recording_user
      
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_recording
      @recording = Recording.cached_find(params[:recording_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recording_user_params
      params.require(:recording_user).permit(:user_id, :recording_id, :email)
    end
end
