class UnreadMessagesController < ApplicationController
  before_filter :access_user, only: [:index]
  def index
    @new_messages = @user.received_massages.where(read: false).order(created_at: :desc).page(params[:page]).per(24)
  end
end
