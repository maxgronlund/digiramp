class PublicOpportunitiesController < ApplicationController
  def index
    PageView.create(url: '/public_opportunities' )
    #@opportunities = Opportunity.order(created_at: :desc).where(public_opportunity: true).last(20)
    @opportunities = Opportunity.order('created_at desc').where(public_opportunity: true).search(params[:query])
  end
  
  def show
    
    begin
      @opportunity = Opportunity.cached_find(params[:id])
      ap @opportunity
      if current_user
        redirect_to user_user_opportunity_path( current_user, @opportunity) if current_user
      else
        forbidden unless @opportunity.public_opportunity
      end
    rescue ActiveRecord::RecordNotFound
      not_found( id: params[:id] )
    end
    #OpportunityView.create(user_id: nil, opportunity_id: @opportunity.id)

  end
end
