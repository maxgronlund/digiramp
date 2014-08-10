class Opportunity::OpportunitiesController < ApplicationController
  
  include OpportunitiesHelper
  before_filter :access_opportunity
  


  def show
    @opportunity.create_activity(  :show, 
                              owner: current_user,
                          recipient: @opportunity,
                     recipient_type: @opportunity.class.name,
                         account_id: @opportunity.account_id)

  end
  
end
