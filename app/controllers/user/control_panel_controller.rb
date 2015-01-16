class User::ControlPanelController < ApplicationController
  
  before_filter :access_user
  include AccountsHelper
  #before_filter :access_account
  
  
  def index
    
    @email_groups = EmailGroup.where(subscripeable: true)
    
    
  end
end
