class FeatureRequestsController < ApplicationController
  
  before_action :access_user, only: [:create, :edit, :update, :new, :destroy]
  before_action :feature_requests
  
  def index
    
  end

  def new
    
  end

  def edit
  
  end

  def show
  
  end
  
private
  # Use callbacks to share common setup or constraints between actions.
  def feature_requests
    @feature_requests       = Blog.cached_find('USER FEATURE REQUESTS')
  end
  
  def feature identifier
    @feature  = BlogPost.cached_find( identifier , blog)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def issue_params
    params.require(:issue).permit!
  end
  
  
end
