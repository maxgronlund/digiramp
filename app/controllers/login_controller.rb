class LoginController < ApplicationController

  
  def new
    @user = current_user
    if params[:recording_id]
      session[:share_recording_id] = params[:recording_id]
    else
      session[:share_recording_id] = nil
    end
  end
end
