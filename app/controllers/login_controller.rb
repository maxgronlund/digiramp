class LoginController < ApplicationController
  #layout "clean_canvas"

  #def index
  #  forbidden
  #  #flash[:info] = { title: "SUCCESS: ", body: "You are logged in" }
  #end
  
  def new
    @user = current_user
    if params[:recording_id]
      session[:share_recording_id] = params[:recording_id]
    else
      session[:share_recording_id] = nil
    end
  end
end
