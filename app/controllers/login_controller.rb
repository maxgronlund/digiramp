class LoginController < ApplicationController
  #layout "clean_canvas"

  def index
    flash[:info] = { title: "Success", body: "You are logged in" }
  end
  
  def new
    
  end
end
