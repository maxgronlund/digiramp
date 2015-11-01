class User::CommonWorkIpiPublishingController < ApplicationController
  
  before_action :access_user
  
  def index
    @common_work_ipi  = CommonWorkIpi.cached_find(params[:common_work_ipi_id])
    @common_work      = @common_work_ipi.common_work
    
  end
  
  def new
    
    @common_work_ipi            = CommonWorkIpi.cached_find(params[:common_work_ipi_id])
    @common_work_ipi_publisher  = CommonWorkIpiPublisher.new
    @common_work                = @common_work_ipi.common_work
  end
  
  def create
    @common_work_ipi            = CommonWorkIpi.cached_find(params[:common_work_ipi_id])
    @common_work                = @common_work_ipi.common_work
    
    if publisher = Publisher.find_by(email: params[:common_work_ipi_publisher][:email])
      params[:common_work_ipi_publisher][:publisher_id] = publisher.id
    end
    if @common_work_ipi_publisher  = CommonWorkIpiPublisher.create(common_work_ipi_publisher_params)
      redirect_to user_user_common_work_ipi_common_work_ipi_publishing_index_path( @user, @common_work_ipi)
    else
      render :new
    end
    
  end
  
  
  def edit
    #@common_work_ipi = CommonWorkIpi.cached_find(params[:id])
    #@ipi_publishers = IpiPublisher.where(email: @user.email.downcase)
  end

  def update
    
    #@common_work_ipi = CommonWorkIpi.cached_find(params[:id])
    #@common_work_ipi.update(common_work_ipi_params)
    #
    #
    #
    #if ipi_publisher = @common_work_ipi.ipi_publisher
    #  @common_work_ipi.update(
    #    publisher_id: ipi_publisher.publisher_id,
    #    publishing_agreement_id: ipi_publisher.publishing_agreement_id 
    #  )
    #end
    #redirect_to user_user_common_work_ipis_path(@user)
  end
  
  
  private
  
  
  def common_work_ipi_publisher_params
    params.require(:common_work_ipi_publisher).permit!
    
  end
end
