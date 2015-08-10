class Opportunity::OpportunitiesController < ApplicationController
  
  #include OpportunitiesHelper
  #before_action :access_opportunity
  def show
    not_found unless @opportunity      = Opportunity.cached_find(params[:id])
    
    
    if params[:opportunity_invitation]  && params[:user_id]
      if @user   = User.cached_find(params[:user_id])
        if (@opportunity_user = OpportunityUser.find_by( opportunity_id: @opportunity.id, user_id: @user.id)) || super?
          
          if current_user
            redirect_to user_user_selected_opportunity_path(@user, @opportunity)
          else
            session[:request_url] = user_user_selected_opportunity_path(@user, @opportunity)
            redirect_to login_new_path
          end
        else
          forbidden
        end
      else
        not_found
      end
    end

  end
  
end
