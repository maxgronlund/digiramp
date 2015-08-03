class Opportunity::OpportunitiesController < ApplicationController
  
  include OpportunitiesHelper
  before_action :access_opportunity
  


  def show
    
  end
  
end
