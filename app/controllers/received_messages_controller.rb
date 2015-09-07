class ReceivedMessagesController < ApplicationController
  before_action :access_user, only: [:index]

  def index
    @received_massages = @user.received_massages.where(recipient_removed: false).order(created_at: :desc).page(params[:page]).per(24)
  end
end
