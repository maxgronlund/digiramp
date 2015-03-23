class User::UserPositionsController < ApplicationController
  before_filter :access_user
  
  def index
    @creative_project_users = CreativeProjectUser.where(user_id: @user.id)
  end
end
