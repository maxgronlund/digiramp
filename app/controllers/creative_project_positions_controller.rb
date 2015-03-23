class CreativeProjectPositionsController < ApplicationController
  def index
    @user = current_user
    @creative_project_roles = CreativeProjectRole.all
  end
end
