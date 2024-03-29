class User::RecordingIpisController < ApplicationController
  before_action :access_user
  
  def new
    @recording        = Recording.cached_find(params[:recording_id])
    @common_work      = @recording.get_common_work
    @recording_ipi    = RecordingIpi.new
      #title:  "Please confirm your rights on #{@recording.title}"                message: "If you confirm this request you can receive creatits and/ or direct payment for usage for the master #{@recording.title}")
    @distribution_agreements  = @user.distribution_agreements
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
    

    params[:recording_ipi][:uuid]                         =  UUIDTools::UUID.timestamp_create().to_s

    @recording        = Recording.cached_find(params[:recording_id])
    #@common_work      = @recording.get_common_work
    
    
    if @recording_ipi = RecordingIpi.create(recording_ipi_params)
      if  params[:commit] == 'Save and send message'
        @recording_ipi.send_confirmation_request 
      elsif params[:commit] == "I'm the only contributor"
        @recording_ipi.accepted!
      end
      redirect_to user_user_recording_right_path(@user, @recording)
    else
      ErrorNotification.post_object( "RecordingIpisController#create", @recording_ipi )
      render :new
    end
  end
  
  
  def edit
    @recording                = Recording.cached_find(params[:recording_id])
    @common_work              = @recording.get_common_work
    @recording_ipi            = RecordingIpi.cached_find(params[:id])
    @distribution_agreements  = @user.distribution_agreements
  end
  
  
  def update    

    @recording        = Recording.cached_find(params[:recording_id])
    @recording_ipi    = RecordingIpi.cached_find(params[:id])
    @common_work      = @recording.get_common_work
    #if params[:commit] == 'Update'
    #  @recording_ipi.update(recording_ipi_params)
    #  redirect_to user_user_recording_right_path(@user, @recording)
    #else

    if user   = User.find_by(email: params[:recording_ipi][:email])
      params[:recording_ipi][:user_id]                    = user.id
      params[:recording_ipi][:account_id]                 = user.account.id
      params[:recording_ipi][:confirmed]                  = false
      params[:recording_ipi][:user_uuid]                  = user.uuid  
    end

    if @recording_ipi.update(recording_ipi_params)
      
      #SalesService.new(@recording.id)
      #sales_service.validate
      @recording_ipi.send_confirmation_request
      if  params[:commit] == 'Save and send message'
        redirect_to user_user_recording_right_path(@user, @recording)
      end
      
      
      
      #if  params[:commit] == 'Save and send message' 
      #  @recording_ipi.send_confirmation_request 
      #  redirect_to user_user_recording_right_path(@user, @recording)
      #elsif params[:commit] == "Send"
      #  @recording_ipi.send_confirmation_request
      #else
      #  redirect_to user_user_recording_right_path(@user, @recording)
      #end
    else
      render :edit
    end
      #end
  end
  
  def show
    @recording_ipi     = RecordingIpi.cached_find(params[:id])
  end
  
  def destroy
    @recording_ipi     = RecordingIpi.cached_find(params[:id])
    @recording_ipi.destroy
    @recording        = Recording.cached_find(params[:recording_id])
    #@common_work      = @recording.get_common_work
    redirect_to user_user_recording_right_path(@user, @recording)
  end
  

  
private

  def recording_ipi_params
    params.require(:recording_ipi).permit!
  end
end
