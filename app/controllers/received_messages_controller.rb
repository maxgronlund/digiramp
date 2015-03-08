class ReceivedMessagesController < ApplicationController
  before_filter :access_user, only: [:index]

  def index
    @received_massages = @user.received_massages.order(created_at: :desc).page(params[:page]).per(24)
  end
end
