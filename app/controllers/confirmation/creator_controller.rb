class Confirmation::CreatorController < ApplicationController
  def edit
    @common_work_ipi = CommonWorkIpi.find_by(uuid: params[:uuid]) 
    @user = @common_work_ipi.user
  end

  def update
  end
end
