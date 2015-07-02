class User::RecordingIpisController < ApplicationController
  before_action :access_user
  
  def new
    @recording        = Recording.cached_find(params[:recording_id])
    @common_work      = @recording.common_work
    @recording_ipi    = RecordingIpi.new( title:  "Please confirm your rights on #{@recording.title}",
                      message: "If you confirm this request you can receive creatits and/ or direct payment for usage for the master #{@recording.title}")

  end
  
  def create
    if user   = User.find_by(email: params[:recording_ipi][:email])
      params[:recording_ipi][:user_id]                    = user.id
      params[:recording_ipi][:account_id]                 = user.account.id
      params[:recording_ipi][:name]                       = user.full_name                                                    
      
      params[:recording_ipi][:show_credit_on_recording]   = false
      params[:recording_ipi][:confirmed]                  = false
      params[:recording_ipi][:user_uuid]                  = user.uuid  
    end
    
    params[:recording_ipi][:confirmation]                 = 'Pending'

    @recording        = Recording.cached_find(params[:recording_id])
    @common_work      = @recording.common_work
    
    if @recording_ipi = RecordingIpi.create(recording_ipi_params)
      redirect_to user_user_common_work_path(@user, @common_work)
      @recording_ipi.send_confirmation_request
    else
      render :new
    end
    
  end
  
  
  def edit
    @recording        = Recording.cached_find(params[:recording_id])
    @common_work      = @recording.common_work
    @recording_ipi     = RecordingIpi.cached_find(params[:id])
  end
  
  
  
  def update    
    
    if user   = User.find_by(email: params[:recording_ipi][:email])
      params[:recording_ipi][:user_id]                    = user.id
      params[:recording_ipi][:account_id]                 = user.account.id
                                                          
      params[:recording_ipi][:confirmation]               = 'Pending'
      params[:recording_ipi][:show_credit_on_recording]   = false
      params[:recording_ipi][:confirmed]                  = false
      params[:recording_ipi][:user_uuid]                  = user.uuid  
    end

    
    @recording_ipi    = RecordingIpi.cached_find(params[:id])
    @recording        = Recording.cached_find(params[:recording_id])
    @common_work      = @recording.common_work
    
    if @recording_ipi.update(recording_ipi_params)
      redirect_to user_user_common_work_path(@user, @common_work)
      
      
      
      @recording_ipi.send_confirmation_request if  params[:commit] == 'Save and send message'
    else
      render :edit
    end

  end
  
  def show
    @recording_ipi     = RecordingIpi.cached_find(params[:id])
  end
  
  def destroy
    @recording_ipi     = RecordingIpi.cached_find(params[:id])
    @recording_ipi.destroy
    @recording        = Recording.cached_find(params[:recording_id])
    @common_work      = @recording.common_work
    redirect_to user_user_common_work_path(@user, @common_work)
  end
  

  
private

  def recording_ipi_params
    params.require(:recording_ipi).permit!
  end
end
