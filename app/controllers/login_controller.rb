class LoginController < ApplicationController
  #layout "clean_canvas"

  def index
    flash[:info] = { title: "SUCCESS: ", body: "You are logged in" }
  end
  
  def new
    
  end
end
