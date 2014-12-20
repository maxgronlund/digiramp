class User::SelectedOpportunitiesController < ApplicationController
  
  before_filter :access_user, only: [:index, :show]
  include AccountsHelper
  before_filter :access_account

  
  def index
    
    @authorized      = true if current_user.id = @user.id
    opportunity_ids  = SelectedOpportunity.where(user_id: @user.id, archived: false).pluck(:opportunity_id)
    @opportunities   = Opportunity.order('deadline desc').where(id: opportunity_ids)
    
  end

  def show
    
    
    
    
  end

  def destroy
  end
end
