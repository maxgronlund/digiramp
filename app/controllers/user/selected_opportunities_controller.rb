class User::SelectedOpportunitiesController < ApplicationController
  
  before_filter :access_user
  include AccountsHelper
  before_filter :access_account

  
  def index
    
    #@authorized      = true if current_user.id = @user.id
    opportunity_ids  = SelectedOpportunity.where(user_id: @user.id, archived: false).pluck(:opportunity_id)
    @opportunities   = Opportunity.order('deadline desc').where(id: opportunity_ids).search(params[:query])
    
  end



  def show
  
    begin
      @opportunity = Opportunity.cached_find(params[:id])
      
      selected_opportunity = SelectedOpportunity.where(user_id: @user.id, opportunity_id: @opportunity.id)
                                                .first_or_create(user_id: @user.id, opportunity_id: @opportunity.id)
      
      
                                                ap @opportunity
      selected_opportunity.archived = false
      selected_opportunity.save!
      
      @opportunity.create_activity(  :show, 
                                owner: current_user,
                            recipient: @opportunity,
                       recipient_type: @opportunity.class.name,
                           account_id: @opportunity.account_id)
      
      
      
      
      unless OpportunityView.where(user_id: current_user.id, opportunity_id: @opportunity.id, created_at: (Time.now - 300)..Time.now).count > 0
         OpportunityView.create(user_id: current_user.id, opportunity_id: @opportunity.id)
      end
    rescue
      not_found params
    end
  end

  def destroy
    @opportunity = Opportunity.cached_find(params[:id])
  
    SelectedOpportunity.where(opportunity_id: @opportunity.id, user_id: current_user.id, )
    selected_opportunity = SelectedOpportunity.where(user_id: @user.id, opportunity_id: @opportunity.id)
                                              .first_or_create(user_id: @user.id, opportunity_id: @opportunity.id)
  
  
    selected_opportunity.archived = true
    selected_opportunity.save!
    
    

  end
  
  
end




