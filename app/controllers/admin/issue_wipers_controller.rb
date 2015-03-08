class Admin::IssueWipersController < ApplicationController
  
  before_filter :admins_only

  def index
    IssueEvent.delete_all
    redirect_to admin_issue_events_path
  end



 
end
