class Opportunity::OpportunitiesController < ApplicationController
  
  include OpportunitiesHelper
  before_action :access_opportunity
  


  def show
    @opportunity.create_activity(  :show, 
                              owner: current_user,
                          recipient: @opportunity,
                     recipient_type: @opportunity.class.name,
                         account_id: @opportunity.account_id)
    @user = current_user
  end
  
end
