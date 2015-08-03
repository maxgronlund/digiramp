class User::PrivateOpportunitiesController < ApplicationController
  before_action :access_user
  #include AccountsHelper
  #before_action :access_account

  
  def index
    PageView.create(url: '/user/private_opportunities' )
    
    opportunity_ids   = OpportunityUser.where(user_id: @user.id).pluck(:opportunity_id)
    opportunity_ids  -= SelectedOpportunity.where(user_id: @user.id, archived: true).pluck(:opportunity_id)
    opportunity_ids.uniq!
    #opportunities     = Opportunity.order('created_at desc').where(id: opportunity_ids).search(params[:query])
    @opportunities     = Opportunity.order('created_at desc').where(id: opportunity_ids)
    
    
    ##@authorized     = true if current_user.id == @user.id
    #
    #opportunity_ids  =  Opportunity.where(public_opportunity: true).pluck(:id)
    #opportunity_ids  += OpportunityUser.where(user_id: @user.id).pluck(:opportunity_id)
    #opportunity_ids  -= SelectedOpportunity.where(user_id: @user.id, archived: true).pluck(:opportunity_id)
    #
    #
    #opportunity_ids.uniq!
    #
    #@opportunities = Opportunity.order('created_at desc').where(id: opportunity_ids).search(params[:query])
  end
end
