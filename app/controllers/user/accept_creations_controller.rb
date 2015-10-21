class User::AcceptCreationsController < ApplicationController
  
  def show
    common_work_ipi   = CommonWorkIpi.find_by(uuid: params[:id])
    ap common_work_ipi
    @user = common_work_ipi.user
    ap @user
  end
end
