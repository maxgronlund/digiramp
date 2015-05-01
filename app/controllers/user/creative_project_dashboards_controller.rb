class User::CreativeProjectDashboardsController < ApplicationController
  
  #before_action  :permit_creative_project_user
  
  def index
    @user                     = User.cached_find(params[:user_id])
    @creative_project         = CreativeProject.cached_find(params[:creative_project_id])
    @creative_project_users   = @creative_project.creative_project_users.where(approved_by_project_manager: true, approved_by_user: true)
  end
  

  
end
