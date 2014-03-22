class RecordingsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  before_filter :there_is_access_to_the_account
  
  def index
    @recordings     = Recording.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(32)
    @show_more      = true
  end

  def show
    @common_work    = CommonWork.find(params[:common_work_id])
    @recording      = Recording.find(params[:id])
    @can_edit       = false
    
    if @common_work.is_accessible_by current_user
      if current_user.can_administrate @account
        @can_edit       = true
      #else
      #  work_user = WorkUser.where(user_id: current_user.id, common_work_id: @common_work.id).first
      #  @user_can_access_files                = work_user.access_files
      #  @user_can_access_legal_documents      = work_user.access_legal_documents
      #  @user_can_access_financial_documents  = work_user.access_financial_documents
      #  @user_can_access_ipis                 = work_user.access_ipis
      end
    else
      render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
    end
    
    
    
  end
  
  def edit
    @common_work    = CommonWork.find(params[:common_work_id])
    @recording      = Recording.find(params[:id])
  end
  
  def new
    @common_work    = CommonWork.cached_find(params[:common_work_id])
    @recording      = Recording.new
  end
  
  def create
    @common_work          = CommonWork.cached_find(params[:common_work_id])
    @recording            = Recording.new(audio_upload: params[:transloadit], account_id: @account.id, title: params[:title], common_work_id: @common_work.id)
    @recording.title      = @recording.audio_upload[:uploads][0][:name]
    @recording.mp3        = @recording.audio_upload[:results][:mp3][0][:url]
    @recording.waveform   = @recording.audio_upload[:results][:waveform][0][:url]
    @recording.thumbnail  = @recording.audio_upload[:results][:thumbnail][0][:url]
    @recording.category   = 'none'
    @recording.cache_version += 1
    @recording.save!
    @recording.extract_metadata
    @recording.update_completeness
    
    redirect_to account_work_path(@account, @common_work )
    
  end
  
  def update
    @common_work    = CommonWork.find(params[:common_work_id])
    @recording      = Recording.find(params[:id])
    params[:recording][:version] = @recording.cache_version + 1
    if @recording.update_attributes(recording_params)
      @recording.update_completeness
      #redirect_to edit_account_common_work_audio_file_path(@account, @common_work, @recording)
      if @recording.instrumental
         redirect_to account_common_work_recording_path(@account, @common_work, @recording)
      else
        redirect_to edit_account_common_work_lyric_path @account, @common_work, @recording
      end
      
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
    redirect_to_return_url account_recordings_path( @account, page: params[:page])
  end
  
  def upload_completed
    @recording      = Recording.find(params[:recording_id])
    @recording.extract_metadata

    if @recording.common_work.nil? && !CommonWork.account_search(@account, @recording.title).empty? 
      # If the common_work is not set and there is common_works with the same name as the recording
      redirect_to edit_account_recording_common_work_path(@account, @recording)
    elsif @recording.common_work.nil?
      # else if the common_work is not set and there is no common_works with the same title
      common_work = CommonWork.create(account_id: @recording.account_id, title: @recording.title, lyrics: @recording.lyrics)
      @recording.common_work_id = common_work.id
      @recording.cache_version += 1
      @recording.save!
    end                        
  end
  
  
  
  
  
  def select_category
    @blog               = Blog.recordings
    @recording          = Recording.find(params[:recording_id])

    if params[:recording]
      @recording.title        = params[:recording][:title]      if params[:recording][:title]
      @recording.has_lyrics   = params[:recording][:has_lyrics] if params[:recording][:has_lyrics]
      @recording.explicit     = params[:recording][:explicit]   if params[:recording][:explicit]
      @recording.category     = params[:recording][:category]   if params[:recording][:category]
      @recording.cache_version += 1
      @recording.save
    end
    
  end

  def add_genre
    @blog           = Blog.recordings
    @recording      = Recording.find(params[:recording_id])
    if params[:recording]
      @recording.category = params[:recording][:category]
      @recording.cache_version += 1
      @recording.save
    end
    @blog               = Blog.recordings
    

    
  end


  def add_mood
    @blog           = Blog.recordings
    @recording      = Recording.find(params[:recording_id])
    if params[:recording]
      @recording.category = params[:recording][:category]
      @recording.cache_version += 1
      @recording.save
    end
    @blog               = Blog.recordings
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
