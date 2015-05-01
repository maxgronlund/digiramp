class Admin::EngineRoomController < ApplicationController
  before_action :admin_only
  def index
    session[:user_id] = current_user.id
  end
end
