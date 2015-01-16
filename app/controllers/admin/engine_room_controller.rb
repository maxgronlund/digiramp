class Admin::EngineRoomController < ApplicationController
  before_filter :admin_only
  def index
    session[:user_id] = current_user.id
  end
end
