class User::ControlPanelController < ApplicationController
  
  before_action :access_user
  #include AccountsHelper
  #before_action :access_account
  
  
  def index
  end
end
