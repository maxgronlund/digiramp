class RecordingDeparturesController < ApplicationController
  
  include AccountsHelper
  before_action :get_account_account
  
  def index
    forbidden unless current_account_user && current_account_user.create_recording
    @user = current_user
  end

  def update
  end
end
