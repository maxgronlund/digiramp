class Opportunity::OpportunitiesController < ApplicationController
  
  #include OpportunitiesHelper
  #before_action :access_opportunity
  def show
    not_found unless @opportunity      = Opportunity.cached_find(params[:id])
    not_found unless @user             = User.cached_find(params[:user_id])
    unless super?
      not_found unless @opportunity_user = OpportunityUser.find_by( opportunity_id: @opportunity.id, user_id: @user.id)
    end 
          
    if current_user.nil?
      session[:request_url] = url_for( controller: 'user/selected_opportunities', action: 'show', user_id: @user.id, id: @opportunity.id )
      redirect_to login_new_path
    elsif current_user.id == @user.id || super?
      redirect_to user_user_selected_opportunity_path(@user, @opportunity)
    else
      forbidden
    end
  end
  
end
