module OpportunitiesHelper
  
  def access_opportunity 
    
    if params[:opportunity_invitation] && params[:user_id] && params[:id]
      check_invitation  
    else
      
      return forbidden if current_user.nil?
      begin
        opportunity_id      = params[:opportunity_id] || params[:id]
        @opportunity        = Opportunity.cached_find(opportunity_id)
        @opportunity_user  = OpportunityUser.where(opportunity_id: @opportunity.id, user_id: current_user.id).first
        forbidden unless @opportunity_user
        #not_fount unless @account  == current_user.account
        @authorized         = true
        return
      rescue
        
      end
      not_found
    end
  end
  
private
  
  def check_invitation

    begin 
      # check if the opportunity, user and opportunity_user exists
      @opportunity        = Opportunity.cached_find(params[:id])
      @user               = User.cached_find(params[:user_id])
      @opportunity_user   = OpportunityUser.where(opportunity_id: params[:id], user_id: params[:user_id]).first
      
      # success the invited user is on the guest list
      if @opportunity_user
        session[:request_url]  = opportunity_opportunity_path( @opportunity )
        # check if we are logged in as the right user
        if current_user 
          if current_user.id == @opportunity_user.user_id
            # everything is ok 
            @authorized            = true
            session[:request_url] = nil
            return
          else
            # we are logged in as another user
            flash[:danger] =  "You are not logged in as the user invited to this opportunity, please log out and try again" 
            redirect_to login_new_path
            return
          end
        else
          redirect_to login_new_path
          return
        end
        
      else
        session[:request_url] = nil
        return forbidden
      end
      
    rescue
      flash[:danger] =  "The invitation is not for you, or the opportunity has been removed" 
      redirect_to current_user ? current_user : login_new_path
      return
    end
  end
  
  
end
