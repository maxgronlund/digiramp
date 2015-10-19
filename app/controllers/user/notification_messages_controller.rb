class User::NotificationMessagesController < ApplicationController
  
  before_action :access_user
  
  
  def index
    @notification_messages = @user.notification_messages.order(:created_at)
  end

  def show
    @notification_message = NotificationMessage.cached_find(params[:id])
  end
end
