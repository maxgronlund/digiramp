class User::OpportunitiesController < ApplicationController
  
  before_action :access_user
  #include AccountsHelper
  #before_action :access_account

  
  def index
    PageView.create(url: '/user/opportunities' )

    opportunity_ids  =  Opportunity.where(public_opportunity: true).pluck(:id)
    opportunity_ids  += OpportunityUser.where(user_id: @user.id).pluck(:opportunity_id)
    opportunity_ids  -= SelectedOpportunity.where(user_id: @user.id, archived: true).pluck(:opportunity_id)
    opportunity_ids.uniq!
    
    @opportunities = Opportunity.order('created_at desc').where(id: opportunity_ids).search(params[:query])
  end
  
  
  def show
    
    begin
      @opportunity = Opportunity.cached_find(params[:id])
      
      selected_opportunity = SelectedOpportunity.where(user_id: @user.id, opportunity_id: @opportunity.id)
                                                .first_or_create(user_id: @user.id, opportunity_id: @opportunity.id)

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
    
    selected_opportunity = SelectedOpportunity.where(user_id: @user.id, opportunity_id: @opportunity.id)
                                              .first_or_create(user_id: @user.id, opportunity_id: @opportunity.id)
    
    selected_opportunity.archived = true
    selected_opportunity.save!

  end

  
end


#- opportunity_link = @user.account.id == opportunity.account_id ? account_account_opportunity_path(@user.account, opportunity)  : opportunity_opportunity_path(opportunity)