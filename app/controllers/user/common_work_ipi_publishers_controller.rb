class User::CommonWorkIpiPublishersController < ApplicationController
  
  before_action :access_user
  def edit
    @common_work_ipi = CommonWorkIpi.cached_find(params[:id])
    @ipi_publishers = IpiPublisher.where(email: @user.email.downcase)
  end

  def update

    @common_work_ipi = CommonWorkIpi.cached_find(params[:id])
    @common_work_ipi.update(common_work_ipi_params)
    
    
    
    if ipi_publisher = @common_work_ipi.ipi_publisher
      @common_work_ipi.update(publisher_id: ipi_publisher.publisher_id)
    end
    redirect_to user_user_common_work_ipis_path(@user)
  end
  
  
  private
  
  
  def common_work_ipi_params
    params.require(:common_work_ipi).permit(:ipi_publisher_id)
    
  end
end
