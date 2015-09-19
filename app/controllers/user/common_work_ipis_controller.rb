class User::CommonWorkIpisController < ApplicationController
  before_action :access_user
  
  def index
  end

  def edit
    @common_work              = CommonWork.cached_find(params[:common_work_id])
    @common_work_ipi          = CommonWorkIpi.cached_find(params[:id])
    @publishing_agreements    = @user.publishing_agreements
    
    if ipi = @common_work_ipi.ipi
      if user = ipi.user
        @common_work_ipi_user = user
        
      end
    end
   
    #@publishing_agreements    = PublishingAgreement.where(email: @ipi.email)
  end
  
  def update
    @common_work              = CommonWork.cached_find(params[:common_work_id])
    @common_work_ipi          = CommonWorkIpi.find(params[:id])
    
    if @common_work_ipi.update(common_work_ipi_params)
      @common_work_ipi.attach_to_ip
      redirect_to user_user_common_work_path(@user, @common_work)
    else
      render :edit
    end
  end

  def new
    @common_work        = CommonWork.cached_find(params[:common_work_id])
    @common_work_ipi    = CommonWorkIpi.new
    @publishing_agreements = @user.publishing_agreements
  end
  
  def create

    @common_work           = CommonWork.cached_find(params[:common_work_id])
    if @common_work_ipi    = CommonWorkIpi.create(common_work_ipi_params)
      @common_work_ipi.attach_to_ip
      redirect_to user_user_common_work_path( @user, @common_work)
    else
      render :new
    end
    
  end
  
  def destroy
    @common_work           = CommonWork.cached_find(params[:common_work_id])
    @common_work_ipi          = CommonWorkIpi.cached_find(params[:id])
    @common_work_ipi.destroy
    redirect_to user_user_common_work_path( @user, @common_work)
  end
  
  
  private
  
  def common_work_ipi_params
    params.require(:common_work_ipi).permit!
  end
end
