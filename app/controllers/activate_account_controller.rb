class ActivateAccountController < ApplicationController


  def edit
    @user = User.find_by_password_reset_token!(params[:id])
    @opportunity = Opportunity.cached_find(params[:opportunity_id])
  end
  
  def update
    
    @user = User.find_by_password_reset_token!(params[:id])
    
    @opportunity = Opportunity.cached_find(params[:user][:opportunity_id])
    params[:user].delete :opportunity_id
    params[:user][:account_activated] = true
    if @user.password_reset_sent_at < 7.days.ago
      redirect_to root_path, :alert => "Invitation &crarr; 
        reset has expired."
    
    elsif @user.update(user_params)
      
      @user.create_activity(  :account_activation, 
                            owner: @user,
                        recipient: @user,
                   recipient_type: @user.class.name,
                       account_id: @user.account_id,
                           )
                       
                       
      flash[:info] = { title: "SUCCESS: ", body: "Your account has been activated" }
      cookies.permanent[:auth_token]  = nil
      cookies[:auth_token]            = @user.auth_token  
      
      if @user.current_account
        redirect_to opportunity_opportunity_path(@opportunity)
      else
        redirect_to root_path
      end

    else
      render :edit
    end
  end
  
  def user_params
    params.require(:user).permit!
  end
  
end