class User::RecordingTransfersController < ApplicationController
  
  before_filter :access_user
  
  
  def edit
  end

  def update
    
    @recording = Recording.find(params[:id])
    if  @recording.user_id == current_user.id || current_user.super?
      @recording.transferable  = params[:recording][:transferable]
      @recording.transfer_code = UUIDTools::UUID.timestamp_create().to_s
      @recording.save
    end
    
  end
  
  def index
    
  end
  
  def show
    forbidden unless current_user
    
    @recording  = Recording.find(params[:id])
    
    if  @recording.user_id == current_user.id || current_user.super?
      #@user       = current_user
      @authorized = true
    else
      forbidden
    end
  end
end
