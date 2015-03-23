class CreativeProjectsController < ApplicationController
  def index
    @user = current_user if current_user
    @creative_projects = CreativeProject.where(public_project: true).order(:created_at)
  end

  def show
    @user = current_user if current_user
    @creative_project = CreativeProject.cached_find(params[:id])
  end
end
