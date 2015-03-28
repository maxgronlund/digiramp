class User::IpisController < ApplicationController
  
  before_filter :access_user
  
  def new
    @common_work  = CommonWork.cached_find(params[:common_work_id])
    @ipi          = Ipi.cached_find(params[:ipi])
    @ipi.title    = "Please confirm your rights on #{@common_work.title}"
    @ipi.message  = "Hi \nI would like you to confirm you share and rights on #{@common_work.title} as:\n#{@ipi.roles_as_string} \n\n--#{@user.user_name}"
    #render nothing: true
  end
  
  def update
    @common_work  = CommonWork.cached_find(params[:common_work_id])
    @ipi          = Ipi.cached_find(params[:id])
    @ipi.update(ipi_params)
    @ipi.send_confirmation_request
  end
  
 
  
private

  def ipi_params
    params.require(:ipi).permit!
  end
  
  
end