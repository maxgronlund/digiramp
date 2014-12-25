class User::OpportunitiesController < ApplicationController
  
  before_filter :access_user
  include AccountsHelper
  before_filter :access_account

  
  def index
    #@authorized     = true if current_user.id == @user.id

    opportunity_ids  =  Opportunity.where(public_opportunity: true).pluck(:id)
    opportunity_ids  += OpportunityUser.where(user_id: @user.id).pluck(:opportunity_id)
    opportunity_ids.uniq!
    
    @opportunities = Opportunity.order('deadline desc').where(id: opportunity_ids).search(params[:query])
  end
  
  
  def show
    
     
    @opportunity = Opportunity.cached_find(params[:id])
    
    selected_opportunity = SelectedOpportunity.where(user_id: @user.id, opportunity_id: @opportunity.id)
                                              .first_or_create(user_id: @user.id, opportunity_id: @opportunity.id)
    
    

    
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
    
    selected_opportunity = SelectedOpportunity.where(user_id: @user.id, opportunity_id: @opportunity.id)
                                              .first_or_create(user_id: @user.id, opportunity_id: @opportunity.id)
    
    
    selected_opportunity.archived = true
    selected_opportunity.save!

  end

  
end


#- opportunity_link = @user.account_id == opportunity.account_id ? account_account_opportunity_path(@user.account, opportunity)  : opportunity_opportunity_path(opportunity)