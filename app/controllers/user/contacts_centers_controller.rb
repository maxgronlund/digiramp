class User::ContactsCentersController < ApplicationController
  
  before_filter :access_user
  include AccountsHelper
  before_filter :access_account
  
  
  def index
    
    
  end
end
