class User::UserNotificationsController < ApplicationController
  
  before_action :access_user
  
  
  def index
    @user_notifications = @user.user_notifications.order(:created_at)
  end

  def show
  end
end
