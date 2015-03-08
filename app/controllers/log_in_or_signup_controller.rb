class LogInOrSignupController < ApplicationController
  def new
    ap params
    @message                = params[:message]
    session[:go_to_message] = params[:bounce_back]
  end
end
