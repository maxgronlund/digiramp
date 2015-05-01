class User::RemovedOpportunitiesController < ApplicationController
  
  before_action :access_user
  include AccountsHelper
  before_action :access_account
  
  
  
  def index
    

    opportunity_ids  = SelectedOpportunity.where(user_id: @user.id, archived: true).pluck(:opportunity_id)
    #@opportunities   = Opportunity.order('deadline desc').where(id: opportunity_ids)
    @opportunities = Opportunity.order('deadline desc').where(id: opportunity_ids).search(params[:query])
    
  end
  
  # move an opportunity to the archive
  def show
    #@opportunity = Opportunity.cached_find(params[:id])
    
    #selected_opportunity = SelectedOpportunity.where(user_id: @user.id, opportunity_id: @opportunity.id)
    #                                          .first_or_create(user_id: @user.id, opportunity_id: @opportunity.id)
    #selected_opportunity.archived = true
    #selected_opportunity.save
    
    @opportunity = Opportunity.cached_find(params[:id])
    
    selected_opportunity = SelectedOpportunity.where(user_id: @user.id, opportunity_id: @opportunity.id)
                                              .first_or_create(user_id: @user.id, opportunity_id: @opportunity.id)
    
    
    #selected_opportunity.archived = false
    #selected_opportunity.save
    
    @opportunity.create_activity(  :show, 
                              owner: current_user,
                          recipient: @opportunity,
                     recipient_type: @opportunity.class.name,
                         account_id: @opportunity.account_id)
    
    @user       = current_user
    @authorized = true
                                              
                              
  end

  def destroy
    @opportunity = Opportunity.cached_find(params[:id])
    if selected_opportunity = SelectedOpportunity.where(user_id: @user.id, opportunity_id: @opportunity.id).first
      selected_opportunity.destroy
    end

  end
end
