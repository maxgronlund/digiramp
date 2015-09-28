class User::RecordingRightsController < ApplicationController
  before_action :access_user
  def show
    @recording        = Recording.cached_find(params[:id])
    
  end
end
