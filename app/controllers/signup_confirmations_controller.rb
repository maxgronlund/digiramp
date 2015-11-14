class SignupConfirmationsController < ApplicationController
  def show
  end

  def edit
   
      
    # the confirmation is valid  
    if @user = User.find_by(confirmation_token: params[:id])
      ap 'user found in invitation'
      # The user is signed in but as another person than the sonfirmation was send to
      if current_user && current_user != @user
        redirect_to signed_in_signup_confirmation_path(current_user)
      
      
      # the user is already signed in
      elsif current_user
        redirect_to @user
      
      # the user is not confirmed
      elsif @user.confirmed_at.nil?
        # the confirmation is expired
        if @user.confirmation_sent_at < Time.now - 2.days
          ap 'confirmation expired'
          redirect_to expired_signup_confirmation_path(params[:id])
        
        
        # the confirmation is perfect
        else
          @user.update_columns(
            private_profile: false, 
            confirmed_at:    Time.now
          )
          sign_in
          flash[:info] = "Your account has been activated"
          redirect_to user_user_user_configurations_path(@user)
        end
      else
        redirect_to @user
      end
    else
      redirect_to invalid_signup_confirmation_path(params[:id])
    end
  end

  def update
  end
  
  def expired
    if @user = User.find_by(confirmation_token: params[:id])
      
    else
      not_found
    end
  end
  
  def resent
    ap params
    if @user = User.find_by(confirmation_token: params[:id])
      @user.confirmation_token
      UserMailer.delay.confirm_signup( @user.id )
    end
  end
  
  def invalid
    
  end
  
  def signed_in
    ap current_user
    @user = current_user
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
