class User::RequestIpiConfirmationsController < ApplicationController
  def update
    ap params
    @user         = User.cached_find(params[:user_id])
    @common_work  = CommonWork.cached_find(params[:common_work_id])
    @ipi          = Ipi.cached_find(params[:id])
    
    @ipi.title    = "Please confirm your rights on #{@common_work.title}"
    @ipi.message  = "Hi \nI would like you to confirm you share and rights on #{@common_work.title} as:\n#{@ipi.roles_as_string} \n\n--#{@user.user_name}"
    #render nothing: true
  end
end
