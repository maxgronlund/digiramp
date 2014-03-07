class RecordingsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
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
    #@common_work    = CommonWork.find(params[:common_work_id])
    @recording      = Recording.find(params[:id])
    #logger.debug '------------------------------------------------'
    #logger.debug @recording[:audio_upload][:results][:mp3].size
    #logger.debug '------------------------------------------------'
    @recording.update_completeness
  end
  
  def edit
    @common_work    = CommonWork.find(params[:common_work_id])
    @recording      = Recording.find(params[:id])
  end
  
  def new
    
    #@new_recording    = BlogPost.where(identifier: 'New Recording', blog_id: @blog.id).first_or_create(identifier: 'New Recording', blog_id: @blog.id, title: 'New Recording', body: 'New recording')
    @recording        = Recording.new
    
  end
  
  def create
    logger.debug("PARAMS: #{params[:transloadit].inspect}")
    @recording = Recording.new(audio_upload: params[:transloadit], account_id: @account.id)
    @recording.save!
    
    #@recording.extract_id3_tags_from_audio_file
    
    redirect_to account_recording_upload_completed(@account, @recording )
    #Rails.logger.info("PARAMS: #{params[:transloadit].inspect}")
    #
    #@recording = Recording.new(audio_upload: params[:transloadit])
    #@recording.save!
    #
    #redirect_to recording_path(@recording)
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
    
    #@common_work    = CommonWork.find(params[:id])
    #@common_work.destroy
    #@account.works_cache_key += 1
    #@account.save
    #redirect_to account_works_path @account
    
    @recording = Recording.find(params[:id])
    @recording.destroy
    redirect_to_return_url account_recordings_path( @account)
  end
  
  def upload_completed
    @recording      = Recording.find(params[:recording_id])
    @blog           = Blog.recordings
    @upload_completed = BlogPost.where(identifier: 'Upload Completed', blog_id: @blog.id)\
                                .first_or_create(identifier: 'Upload Completed', blog_id:\
                                @blog.id, title: 'Upload Completed', body: 'Please provide some basic informations so we can find your recording for you')
                                
    
  end
  
  def select_category
    @recording              = Recording.find(params[:recording_id])
    
    if params[:recording]
      @recording.title        = params[:recording][:title]
      @recording.has_lyrics   = params[:recording][:has_lyrics]
      @recording.explicit     = params[:recording][:explicit]
      @recording.save
    end
    
     
    
    @blog               = Blog.recordings
    @select_category    = BlogPost.where(identifier: 'Select Category', blog_id: @blog.id)\
                               .first_or_create(identifier: 'Select Category', blog_id:\
                               @blog.id, title: 'Select Category', body: '')
                               
                               
    @popular_music = BlogPost.where(identifier: 'Popular Music', blog_id: @blog.id)\
                                .first_or_create(identifier: 'Popular Music', blog_id:\
                                @blog.id, title: 'Popular Music', body: 'Pop Rock')
     
     
    @cinematic = BlogPost.where(identifier: 'Cinematic', blog_id: @blog.id)\
                               .first_or_create(identifier: 'Cinematic', blog_id:\
                               @blog.id, title: 'Cinematic', body: 'For film')
     
     
    @ethnic_world = BlogPost.where(identifier: 'Ethnic/World', blog_id: @blog.id)\
                               .first_or_create(identifier: 'Ethnic/World', blog_id:\
                               @blog.id, title: 'Ethnic/World', body: '')
     
     
    @jazz = BlogPost.where(identifier: 'Jazz', blog_id: @blog.id)\
                               .first_or_create(identifier: 'Jazz', blog_id:\
                               @blog.id, title: 'Jazz', body: '')
     
     
    @classical = BlogPost.where(identifier: 'Classical', blog_id: @blog.id)\
                               .first_or_create(identifier: 'Classical', blog_id:\
                               @blog.id, title: 'Classical', body: '')
     
     
    @other = BlogPost.where(identifier: 'Other', blog_id: @blog.id)\
                               .first_or_create(identifier: 'Other', blog_id:\
                               @blog.id, title: 'Other', body: '')
  end

  def add_genre
    @recording      = Recording.find(params[:recording_id])
    if params[:recording]
      @recording.category = params[:recording][:category]
      @recording.save
    end
    @blog               = Blog.recordings
    @add_genre          = BlogPost.where(identifier: 'Add Genre', blog_id: @blog.id)\
                               .first_or_create(identifier: 'Add Genre', blog_id:\
                               @blog.id, title: 'Add Genre', body: '')

    
  end


  def add_mood

  end

  def add_instruments

  end

  def add_lyrics

  end
  def add_description

  end

  def add_more_meta_data

  end
  def overview

  end
  
private
  
  def recording_params
    params.require(:recording).permit!
  end
  
  
end
