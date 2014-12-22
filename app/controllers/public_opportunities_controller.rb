class PublicOpportunitiesController < ApplicationController
  def index
    @opportunities = Opportunity.order(created_at: :desc).where(public_opportunity: true).last(20)
  end
end
