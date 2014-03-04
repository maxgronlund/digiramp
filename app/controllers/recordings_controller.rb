class RecordingsController < ApplicationController
  before_filter :there_is_access_to_the_account
  
  def index
    @blog               = Blog.recordings
    @manage_recordings  = BlogPost.where(identifier: 'Manage Recordings', blog_id: @blog.id).first_or_create(identifier: 'Manage Recordings', blog_id: @blog.id, title: 'Manage Recordings') 
    
    #@recordings         = @account.recordings
    @recordings         = Recording.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(32)
    #
    #
    #@common_works = CommonWork.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(32)
    ##@common_works  = @account.common_works.order('title asc').page(params[:page]).per(32)
  end

  def show
    @common_work    = CommonWork.find(params[:common_work_id])
    @recording      = Recording.find(params[:id])
  end
  
  def edit
    @common_work    = CommonWork.find(params[:common_work_id])
    @recording      = Recording.find(params[:id])
  end
  
  def update
    @common_work    = CommonWork.find(params[:common_work_id])
    @recording      = Recording.find(params[:id])
    
    if @recording.update_attributes(recording_params)
      redirect_to :back
    else
      redirect_to :back
    end
    
    
    #@account.works_cache_key += 1
    #@account.save
    #if @common_work.update_attributes(common_work_params)
    #  redirect_to account_work_path(@account, @common_work)
    #else
    #  render :edit
    #end
  end
  
  def destroy
    logger.debug '----------------------------------------------------------------'
    logger.debug 'destroy'
    logger.debug '----------------------------------------------------------------'
    #@common_work    = CommonWork.find(params[:id])
    #@common_work.destroy
    #@account.works_cache_key += 1
    #@account.save
    #redirect_to account_works_path @account
    
    @recording = Recording.find(params[:id])
    @recording.destroy
    redirect_to_return_url account_recordings_path( @account)
  end
  
private
  
  def recording_params
    params.require(:recording).permit!
  end
  
  
end
