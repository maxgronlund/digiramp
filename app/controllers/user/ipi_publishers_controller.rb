class User::IpiPublishersController < ApplicationController
  before_action :access_user
  before_action :set_ipi_publisher, only: [:show, :edit, :update, :destroy]

  def index
  
    @publisher = Publisher.cached_find(params[:publisher_id])
    @ipi_publishers = @publisher.ipi_publishers
    
  end
  
  def show
    @publisher = Publisher.cached_find(params[:publisher_id])
  end

  def new
    @publisher      = Publisher.cached_find(params[:publisher_id])
    @ipi_publisher  = IpiPublisher.new
    @publishing_agreements = @publisher.publishing_agreements
   
    
  end

  def create
   
    @publisher      = Publisher.cached_find(params[:publisher_id])
    if @ipi_publisher  = IpiPublisher.create(ipi_publisher_params)
      @ipi_publisher.attach_to_user current_user
      redirect_to user_user_publisher_ipi_publishers_path(@user, @publisher)
    else
      render :new
    end
  end
  
  def edit
    @publisher  = Publisher.cached_find(params[:publisher_id])
    @publishing_agreements = @publisher.publishing_agreements
  end

  def update
   
    @publisher      = Publisher.cached_find(params[:publisher_id])
    if @ipi_publisher.update(ipi_publisher_params)
      @ipi_publisher.attach_to_user current_user
      @ipi_publisher.attach_to_common_work_ipis
      redirect_to user_user_publisher_ipi_publishers_path(@user, @publisher)
    else
      render :edit
    end
  end

  def destroy
    @publisher  = Publisher.cached_find(params[:publisher_id])
    @ipi_publisher.destroy
    redirect_to user_user_publisher_ipi_publishers_path(@user, @publisher)
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ipi_publisher
      @ipi_publisher = IpiPublisher.cached_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ipi_publisher_params
      params.require(:ipi_publisher).permit!
    end
end
