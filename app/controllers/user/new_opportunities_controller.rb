class User::NewOpportunitiesController < ApplicationController
  
  before_action :access_user, only: [:index, :show]
  include AccountsHelper
  before_action :access_account

  
  def index
    @authorized     = true if current_user.id = @user.id
    #@opportunities  = Opportunity.public_opportunities
    
    opportunity_ids  =  Opportunity.where(public_opportunity: true).pluck(:id)
    opportunity_ids  += OpportunityUser.where(user_id: @user.id).pluck(:opportunity_id)
    # dont show selected opportunities
    opportunity_ids  -= SelectedOpportunity.where(user_id: @user.id).pluck(:opportunity_id)
    
    
    opportunity_ids.uniq!
    
    @opportunities = Opportunity.order('deadline desc').where(id: opportunity_ids)
  end
  
  
  def show
    

    @opportunity = Opportunity.cached_find(params[:id])
    
    selected_opportunity = SelectedOpportunity.where(user_id: @user.id, opportunity_id: @opportunity.id)
                                              .first_or_create(user_id: @user.id, opportunity_id: @opportunity.id)
    
    
    selected_opportunity.archived = false
    selected_opportunity.save
    
    @opportunity.create_activity(  :show, 
                              owner: current_user,
                          recipient: @opportunity,
                     recipient_type: @opportunity.class.name,
                         account_id: @opportunity.account_id)
    
    @user       = current_user
    @authorized = true
  end

  
end


#- opportunity_link = @user.account_id == opportunity.account_id ? account_account_opportunity_path(@user.account, opportunity)  : opportunity_opportunity_path(opportunity)