class Opportunity::OpportunitiesController < ApplicationController
  
  include OpportunitiesHelper
  before_filter :access_opportunity
  


  def show
    

  end
  
end
