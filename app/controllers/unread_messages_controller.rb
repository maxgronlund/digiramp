class UnreadMessagesController < ApplicationController
  before_action :access_user
  def index
    @new_messages = @user.received_massages.where(read: false).order(created_at: :desc).page(params[:page]).per(24)
  end
  
  def new
    if new_messages = @user.received_massages.where(read: false)
      new_messages.update_all(read: true)
    end
    redirect_to user_received_messages_path(@user)
  end
  
  
end
