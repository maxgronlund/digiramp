# Send a confirmation request to an commonwork ipi
class User::RequestIpiConfirmationsController < ApplicationController
  def update
    @user             = User.cached_find(params[:user_id])
    @common_work      = CommonWork.cached_find(params[:common_work_id])
    @common_work_ipi  = CommonWorkIpi.cached_find(params[:id])
    
    
    @common_work_ipi.user ? @common_work_ipi.send_notification : @common_work_ipi.check_for_member
    flash[:info] = "Confirmation request is sent" 
    
    #
    #@ipi.title    = "Please confirm your rights on #{@common_work.title}"
    #@ipi.message  = "Hi \nI would like you to confirm you share and rights on #{@common_work.title}"
    #render nothing: true
    redirect_to :back
  end
end
