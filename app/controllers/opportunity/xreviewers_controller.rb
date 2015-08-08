class Opportunity::ReviewersController < ApplicationController
  #include OpportunitiesHelper
  #before_action :access_opportunity
  #
  def show
    
    unless current_user.nil?
      if params[:opportunity_id ]  && params[:id]
        if @opportunity  = Opportunity.cached_find(params[:opportunity_id])
          if @opportunity_user = OpportunityUser.find_by( uuid: params[:id], opportunity_id: @opportunity.id)
            @user    = @opportunity_user.user
            @account = @user.account
          else
            ap 'opportunity user not found'
            not_found
          end
        else
          ap 'opportunity not found'
          not_found
        end
      else
        ap 'bad params'
        not_found
      end

    else
      redirect_to login_new_path
    end

  end
  
 
end
