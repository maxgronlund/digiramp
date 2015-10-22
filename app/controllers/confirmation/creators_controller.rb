class Confirmation::CreatorsController < ApplicationController
  def edit
    begin
      @common_work_ipi  = CommonWorkIpi.find_by(uuid: params[:uuid]) 
      @user             = User.find_by_password_reset_token!(params[:id])
      @common_work      = @common_work_ipi.common_work
      @invitor          = @common_work.account.user
    rescue
      not_found
    end
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    uuid = params[:user][:uuid]
    params[:user].delete :uuid
    if @user.update(user_params)
      #@user.common_work_ipis.update_all(email: @user.email, full_name: @user.user_name )
      #ap @user.common_work_ipis
      cookies.permanent[:auth_token]  = nil
      cookies[:auth_token]            = @user.auth_token  
      redirect_to session[:request_url]
    else
      params[:user][:uuid] = uuid
      render :edit
    end
  end
private  
  def user_params
    params.require(:user).permit(:password, :password_confirmation, :email, :user_name)
  end
end
