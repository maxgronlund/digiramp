class IssueImagesController < ApplicationController
  #before_filter :access_user, only: [:show]



  # GET /issue_images
  # GET /issue_images.json


  # GET /issue_images/1
  # GET /issue_images/1.json
  def show
     @user = User.cached_find(params[:user_id])
    @issue = Issue.find(params[:id])
  end


end
