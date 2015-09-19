class User::LabelsController < ApplicationController
  before_action :access_user
  def show
    @label = Label.cached_find(params[:id])
  end

  def edit
  end
  
  def index
    @labels = @user.labels
  end
  
  
  def update
    
  end
end
