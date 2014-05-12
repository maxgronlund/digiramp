class IssueImagesController < ApplicationController
  before_filter :access_user, only: [:show]



  # GET /issue_images
  # GET /issue_images.json


  # GET /issue_images/1
  # GET /issue_images/1.json
  def show
    @issue = Issue.find(params[:id])
  end


end
