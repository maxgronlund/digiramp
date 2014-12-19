class User::OpportunitiesController < ApplicationController
  
  before_filter :access_user, only: [:index, :show]
  include AccountsHelper
  before_filter :access_account

  
  def index
    @authorized     = true if current_user.id = @user.id
    #@opportunities  = Opportunity.public_opportunities
    
    opportunity_ids  = Opportunity.where(public_opportunity: true).pluck(:id)
    opportunity_ids  += OpportunityUser.where(user_id: @user.id).pluck(:opportunity_id)
    opportunity_ids.uniq!
    
    @opportunities = Opportunity.order('deadline desc').where(id: opportunity_ids)
  end
  
  
  def show
    # public vs private
    @opportunity = Opportunity.cached_find(params[:id])
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