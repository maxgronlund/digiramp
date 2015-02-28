class SendMessagesController < ApplicationController
  
  before_filter :access_user, only: [:index]

  def index
    @send_massages = @user.send_massages.order(created_at: :desc).page(params[:page]).per(24)
  end
  
end
