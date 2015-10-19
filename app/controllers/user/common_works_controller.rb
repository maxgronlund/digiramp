class User::CommonWorksController < ApplicationController
  before_action :access_user

  
  def index
    
  end

  def show

    @common_work  = CommonWork.cached_find(params[:id])
    @notification_messages = NotificationMessage.where(
      asset_id:   @common_work.id,
      asset_type: @common_work.class.name,
    )

    
    if params[:recording_id]
      @recording  = Recording.cached_find(params[:recording_id])
    else
      @recording  = @common_work.recordings.first
    end


    #if @recording.nil?
    #  redirect_to user_user_common_work_without_recording_path(@user, @common_work)
    #elsif

    #@no_ips     = @common_work.ipis.to_i.count + @recording.recording_ipis.to_i.count == 0

    blog        = Blog.cached_find('Common Work Ipi')
    @no_ipis_text = BlogPost.cached_find('No Ipis' , blog)
    
    @upload_existing_contracts  = BlogPost.cached_find('Upload existing documents' , blog)
    @add_ipis                   = BlogPost.cached_find("Add IPI's" , blog)
    @im_the_only_ip             = BlogPost.cached_find("I'm the only IP" , blog)
    
      
    #end
      
  end

  #def new
  #end
  #
  #def create
  #  
  #end

  def edit
    #@recording    = Recording.cached_find(params[:recording_id])
    @common_work = CommonWork.cached_find(params[:id])
  end

  def update
    #@recording    = Recording.cached_find(params[:common_work][:recording_id])
    #params[:common_work].delete :recording_id
    @common_work  = CommonWork.cached_find(params[:id])
    if @common_work.update(common_work_params)
      
    else
      render :edit
    end
    
    #redirect_to edit_user_user_recording_common_work_lyric_path(@user, @recording, @common_work)
    redirect_to edit_user_user_common_work_lyric_path(@user, @common_work)
    
  end

  def delete
  end
  
private
  def common_work_params
    params.require(:common_work).permit!
  end
end
  
  
