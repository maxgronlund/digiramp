class User::CommonWorksController < ApplicationController
  before_action :access_user

  
  def index
    
  end

  def show
    
    @common_work      = CommonWork.cached_find(params[:id])
    @common_work_user = CommonWorkUser.find_by(user_id: @user.id, common_work_id: @common_work.id)
    forbidden unless (@common_work_user && @common_work_user.can_manage_common_work) || super?
    
    @notification_messages = NotificationMessage.where(
      asset_id:   @common_work.id,
      asset_type: @common_work.class.name,
    )


    blog                        = Blog.cached_find('Common Work Ipi')
    @no_ipis_text               = BlogPost.cached_find('No Ipis' , blog)
    @upload_existing_contracts  = BlogPost.cached_find('Upload existing documents' , blog)
    @add_ipis                   = BlogPost.cached_find("Add IPI's" , blog)
    @im_the_only_ip             = BlogPost.cached_find("I'm the only IP" , blog)
 
  end
  
  def new
    
  end
  
  def create
    
  end


  def edit

    @common_work      = CommonWork.cached_find(params[:id])
    @common_work_user = CommonWorkUser.find_by(user_id: @user.id, common_work_id: @common_work.id)
    forbidden unless (@common_work_user && @common_work_user.can_manage_common_work) || super?
  end

  def update
    #@recording    = Recording.cached_find(params[:common_work][:recording_id])
    #params[:common_work].delete :recording_id
    @common_work      = CommonWork.cached_find(params[:id])
    @common_work_user = CommonWorkUser.find_by(user_id: @user.id, common_work_id: @common_work.id)
    forbidden unless (@common_work_user && @common_work_user.can_manage_common_work) || super?
    if @common_work.update(common_work_params)
      
    else
      render :edit
    end
    
    #redirect_to edit_user_user_recording_common_work_lyric_path(@user, @recording, @common_work)
    redirect_to edit_user_user_common_work_lyric_path(@user, @common_work)
    
  end

  def delete
    @common_work      = CommonWork.cached_find(params[:id])
    @common_work_user = CommonWorkUser.find_by(user_id: @user.id, common_work_id: @common_work.id)
    if (@common_work_user && @common_work_user.can_manage_common_work) || super?
      remove_recordings 
      @common_work.user_id    = User.system_user.id
      @common_work.account_id = User.system_user.account.id
      @common_work.save(validate: false)
      @common_work.common_work_users.destroy_all
      
      CommonWorkUser.create(
        common_work_id: common_work.id,
        common_work_title: common_work.title,
        user_id: User.system_user.id,
        can_manage_common_work: true
      )
      
      
    end
    
    
  end
  
private

  def remove_recordings 
    @common_work.recordings.each do |recording|
      recording.user_id    = User.system_user.id
      recording.account_id = User.system_user.account.id
      recording.privacy    = 'Only me'
      recording.remove_from_collections
      recording.save(validate: false)
    end
  end
  def common_work_params
    params.require(:common_work).permit!
  end
end
  
  
