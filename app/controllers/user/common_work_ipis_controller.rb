class User::CommonWorkIpisController < ApplicationController
  before_action :access_user
  
  def index
    @common_work_ipis        = @user.common_work_ipis.order(:created_at)
  end

  def edit
    @common_work              = CommonWork.cached_find(params[:common_work_id])
    @common_work_ipi          = CommonWorkIpi.cached_find(params[:id])
    #@publishing_agreements    = @user.publishing_agreements
    
    if ipi = @common_work_ipi.ipi
      if user = ipi.user
        @common_work_ipi_user = user
      end
    end

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
    @common_work_ipi    = CommonWorkIpi.new(share: 0)
    @publishing_agreements = @user.publishing_agreements
  end
  
  def create
    params[:common_work_ipi][:publishers_email].downcase! if params[:common_work_ipi][:publishers_email]
    params[:common_work_ipi][:uuid] = UUIDTools::UUID.timestamp_create().to_s

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
