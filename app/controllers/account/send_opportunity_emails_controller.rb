class Account::SendOpportunityEmailsController < ApplicationController
  def show

    @opportunity = Opportunity.cached_find(params[:id])
    @opportunity.notify_oppurtunity_mail_subscribers
    
  end
end
