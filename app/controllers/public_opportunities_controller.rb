class PublicOpportunitiesController < ApplicationController
  def index
    #@opportunities = Opportunity.order(created_at: :desc).where(public_opportunity: true).last(20)
    @opportunities = Opportunity.order('deadline desc').where(public_opportunity: true).search(params[:query])
  end
  
  def show
    @opportunity = Opportunity.cached_find(params[:id])
  end
end
