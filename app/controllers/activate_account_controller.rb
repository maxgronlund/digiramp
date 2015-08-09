class ActivateAccountController < ApplicationController


  def edit
    
    begin
      @user         = User.find_by_password_reset_token!(params[:id])
      
      # get the right record
      if params[:opportunity_id]
        @opportunity        = Opportunity.cached_find(params[:opportunity_id])
      elsif params[:opportunity_user_id]
        @opportunity_user   = OpportunityUser.find_by_uuid(params[:opportunity_user_id])
      end
      
      if current_user
        if current_user.id == @user.id
          if @opportunity 
            redirect_to user_user_selected_opportunity_path(@user, @opportunity)
          elsif @opportunity_user
            redirect_to user_user_opportunities_for_review_path(@user, @opportunity_user.uuid)
          else
            redirect_to edit_user_path(@user)
          end
        else
          @error = 'You are currently logged in as different user than the one who received this invitation.'
          @status = 'logged in on another account'
        end
      end 
    rescue
      forbidden
    end

  end
  
  def update    
    @user = User.find_by_password_reset_token!(params[:id])

    # get the right record
    if opportunity_id = params[:user][:opportunity_id] 
      @opportunity = Opportunity.cached_find(opportunity_id)
      params[:user].delete :opportunity_id
    elsif opportunity_user_uuid = params[:user][:opportunity_user_id] 
      @opportunity_user      = OpportunityUser.find_by_uuid(opportunity_user_uuid)
      params[:user].delete :opportunity_user_id
    end
    
    
    # set the activated flag
    params[:user][:account_activated] = true
    
    # check invitation age
    if @user.password_reset_sent_at < 7.days.ago
      redirect_to root_path, :alert => "Invitation &crarr; 
        reset has expired."
    
    # update user
    elsif @user.update(user_params)
      
      @user.create_activity(  :account_activation, 
                            owner: @user,
                        recipient: @user,
                   recipient_type: @user.class.name,
                       account_id: @user.account.id,
                           )
                       
                       
      
      cookies.permanent[:auth_token]  = nil
      cookies[:auth_token]            = @user.auth_token  
      
      if @user.current_account
        if @opportunity 
          redirect_to user_user_selected_opportunity_path(@user, @opportunity)
        elsif @opportunity_user
          redirect_to user_user_opportunities_for_review_path(@user, @opportunity_user.uuid)
        else
          redirect_to edit_user_path(@user)
        end
      else
        redirect_to root_path
      end

    else
      render :edit
    end
  end
  
  def user_params
    params.require(:user).permit(UserParams::PUBLIC_PARAMS) 
  end
  
end
