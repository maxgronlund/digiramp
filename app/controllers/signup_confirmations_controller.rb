class SignupConfirmationsController < ApplicationController
  def show
  end

  def edit
    
    if @user = User.find_by(confirmation_token: params[:id])
      if @user.confirmed_at.nil?
        @user.update_columns(
          private_profile: false, 
          confirmed_at:    Time.now
        )
        sign_in
        redirect_to user_user_user_configurations_path(@user)
      else
        redirect_to @user
      end
    else
      redirect_to signup_confirmations_invalid_path
    end
  end

  def update
  end
  
  def expired
    
  end
  
  def resent
    
  end
  
  def invalid
    
  end
  
  def not_confirmed
    begin
      @user = User.find_by(confirmation_token: params[:id])
      if @user.confirmed_at.nil?
        @user.update_columns(
          private_profile: false, 
          confirmed_at:    Time.now
        )
        sign_in
        redirect_to user_user_user_configurations_path(@user)
      else
        redirect_to root_path
      end
    rescue
      redirect_to root_path
    end
  end
  
  private
  
    def sign_in
      if @user
        cookies[:auth_token] = @user.auth_token
        
        @user.create_activity(  :signed_in, 
                           owner: @user,
                       recipient: @user,
                  recipient_type: @user.class.name,
                      account_id: @user.account.id) 
                  
        return true          
      end
      false
    end
end
