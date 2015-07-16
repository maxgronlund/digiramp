class LoginController < ApplicationController
  
  def new
    redirect_to user_path(current_user) if @user = current_user
    if params[:recording_id]
      session[:share_recording_id] = params[:recording_id]
    else
      session[:share_recording_id] = nil
    end
  end
end
