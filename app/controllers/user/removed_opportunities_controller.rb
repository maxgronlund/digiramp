class User::RemovedOpportunitiesController < ApplicationController
  
  before_filter :access_user, only: [:index, :show]
  include AccountsHelper
  before_filter :access_account
  
  
  
  def index
    

    opportunity_ids  = SelectedOpportunity.where(user_id: @user.id, archived: true).pluck(:opportunity_id)
    @opportunities   = Opportunity.order('deadline desc').where(id: opportunity_ids)
    
    
  end
  
  # move an opportunity to the archive
  def show
    @opportunity = Opportunity.cached_find(params[:id])
    
    selected_opportunity = SelectedOpportunity.where(user_id: @user.id, opportunity_id: @opportunity.id)
                                              .first_or_create(user_id: @user.id, opportunity_id: @opportunity.id)
    selected_opportunity.archived = true
    selected_opportunity.save
                                              
                              
  end

  def destroy
  end
end
