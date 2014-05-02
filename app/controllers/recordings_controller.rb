class RecordingsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  before_filter :there_is_access_to_the_account
  
  def index
    @recordings     = Recording.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(24)
    @show_more      = true
    
  end

  def show
    @common_work    = CommonWork.cached_find(params[:common_work_id])
    @recording      = Recording.cached_find(params[:id])

    access = false
    
    if current_user.can_administrate @account
      access = true
    elsif @common_work.is_accessible_by current_user
      access = true
    end

    unless access
      render :file => "#{Rails.root}/public/422.html", :status => 422, :layout => false
    end
  end
  
  def edit
    @common_work    = CommonWork.find(params[:common_work_id])
    @recording      = Recording.find(params[:id])
    
    @recording.genre        = @recording.genre_tags_as_csv_string
    @recording.instruments  = @recording.instruments_tags_as_csv_string
    @recording.mood         = @recording.moods_tags_as_csv_string
    
    #@recording.copy_genre_tags_in_to_genre_string
    if params[:genre_category]
      redirect_to account_common_work_recording_genre_tags_path(@account, @common_work, @recording, genre_category: params[:genre_category])
    end
  end
  
  def new
    @common_work    = CommonWork.cached_find(params[:common_work_id])
    @recording      = Recording.new
  end
  
  def create
    @common_work            = CommonWork.cached_find(params[:common_work_id])
    @recording              = Recording.new(audio_upload: params[:transloadit], account_id: @account.id, title: params[:title], common_work_id: @common_work.id)
    @recording.title        = @recording.audio_upload[:uploads][0][:name]
    @recording.mp3          = @recording.audio_upload[:results][:mp3][0][:url]
    @recording.waveform     = @recording.audio_upload[:results][:waveform][0][:url]
    @recording.thumbnail    = @recording.audio_upload[:results][:thumbnail][0][:url]
    #@recording.category   = 'none'
    @recording.cache_version += 1
    @recording.save!
    @recording.extract_metadata
    @recording.update_completeness
    
    redirect_to account_work_path(@account, @common_work )
    
  end
  
  def update
    @common_work    = CommonWork.find(params[:common_work_id])
    @recording      = Recording.find(params[:id])
    params[:recording][:cache_version] = @recording.cache_version + 1

    if @genre_category = params[:recording][:genre_category]
      params[:recording].delete :genre_category
    end

    if @recording.update_attributes(recording_params)
      @recording.extract_genres
      @recording.extract_instruments
      @recording.extract_moods
      @recording.update_completeness
      
      
      if @genre_category
        redirect_to edit_account_common_work_recording_path(@account, @common_work, @recording,genre_category: @genre_category )
      else
        redirect_to account_common_work_recording_path(@account, @common_work, @recording,genre_category: @genre_category )
      end
      #if @genre_category
      #  redirect_to edit_account_common_work_recording_path(@account, @common_work, @recording,genre_category: @genre_category )
      #elsif @recording.instrumental
      #   redirect_to account_common_work_recording_path(@account, @common_work, @recording)
      #else
      #  redirect_to edit_account_common_work_lyric_path @account, @common_work, @recording
      #end
      #
    else
      redirect_to_return_url account_common_work_recording_path(@account, @common_work, @recording)
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
      #@recording.category     = params[:recording][:category]   if params[:recording][:category]
      @recording.cache_version += 1
      @recording.save
    end
    
  end

  def add_genre
    @blog           = Blog.recordings
    @recording      = Recording.find(params[:recording_id])
    if params[:recording]
      #@recording.category = params[:recording][:category]
      @recording.cache_version += 1
      @recording.save
    end
    @blog               = Blog.recordings
    

    
  end


  def add_mood
    @blog           = Blog.recordings
    @recording      = Recording.find(params[:recording_id])
    if params[:recording]
      #@recording.category = params[:recording][:category]
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
  
  #def download
  #  @recording = Recording.cached_find(params[:id])
  #  
  #  original_file_name = 'Audiofile'
  #  if @recording.mp3
  #    original_file_name = Pathname.new(@recording.mp3).basename 
  #  else
  #    original_file_name = @recording.title
  #  end
  #  send_file @recording.mp3 , :type=>"audio/mp3", :filename => original_file_name
  #end
  
  #def download
  #  @recording = Recording.cached_find(params[:id])
  #  AWS.config({
  #    access_key_id: "AKIAIVATNWTNMQZKK2VA",
  #    secret_access_key: "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"
  #  })
  #
  #  send_data( 
  #    AWS::S3.new.buckets["digiramp"].objects["0.mp3"].read, {
  #      filename: "0.mp3", 
  #      type: "audio/mp3", 
  #      disposition: 'attachment', 
  #      stream: 'true', 
  #      buffer_size: '4096'
  #    }
  #  )
  #end
  
  
  
private
  
  def recording_params
    params.require(:recording).permit!
  end
  
  
end
