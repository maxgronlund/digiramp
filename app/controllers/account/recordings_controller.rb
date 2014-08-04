class Account::RecordingsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  include RecordingsHelper
  include AccountsHelper
  before_filter :access_account
  before_filter :read_recording, only:[ :show, 
                                        :files, 
                                        :artwork,
                                        :new_artwork,
                                        :create_artwork
                                      ]
  
  def index
    forbidden unless current_account_user.read_recording?
    @recordings     = Recording.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(48)
    @show_more      = true
  end

  def show
    
    forbidden unless current_account_user.read_recording
    
    #@common_work    = CommonWork.cached_find(params[:common_work_id])
    @recording      = Recording.cached_find(params[:id])


  end
  
  def edit
    forbidden unless current_account_user.update_recording?
    #@common_work    = CommonWork.find(params[:common_work_id])
    @recording              = Recording.find(params[:id])
    
    @recording.genre        = @recording.genre_tags_as_csv_string
    @recording.instruments  = @recording.instruments_tags_as_csv_string
    @recording.mood         = @recording.moods_tags_as_csv_string
    
    
    if params[:genre_category]
      redirect_to account_common_work_recording_genre_tags_path(@account, @common_work, @recording, genre_category: params[:genre_category])
    end
  end
  
  def new
    forbidden unless current_account_user.create_recording?
    #@common_work    = CommonWork.cached_find(params[:common_work_id])
    #@recording      = Recording.new
  end
  
  def create
    forbidden unless current_account_user.create_recording?
    @common_work           = CommonWork.cached_find(params[:common_work_id])
    begin
      TransloaditParser.add_to_common_work params[:transloadit], @common_work.id, @account.id
      flash[:info]      = { title: "Success", body: "Recording added to Common Work" }
      redirect_to account_work_work_recordings_path(@account, @common_work )
    rescue
      flash[:danger]      = { title: "Unable to create Recording", body: "Please check if you selected a valid file" }
      redirect_to new_account_common_work_recording_path(@account, @common_work )
    end
    
  end
  
  def update
    forbidden unless current_account_user.update_recording?
    #@common_work    = CommonWork.find(params[:common_work_id])
    @recording      = Recording.find(params[:id])
    
    
    params[:recording][:uuid] = UUIDTools::UUID.timestamp_create().to_s

    if @genre_category = params[:recording][:genre_category]
      params[:recording].delete :genre_category
    end

    if @recording.update_attributes(recording_params)
      @recording.extract_genres
      @recording.extract_instruments
      @recording.extract_moods

      # artwork
      if params[:transloadit]
        if artworks = TransloaditImageParser.artwork( params[:transloadit], @account.id)
          # if there is no artwork file
          if artworks == []
            # if a drop down item is selected
            if params[:recording][:image_file_id].to_s != ''   
              artwork = Artwork.cached_find(params[:recording][:image_file_id])
              @recording.cover_art  = artwork.thumb
              @recording.save!
            end
          else
            # add the uploaded artwork
            # notice there is only one artwork file
            artworks.each do |artwork|
                                  
              RecordingItem.create( recording_id: @recording.id, 
                                    itemable_type: 'Artwork',
                                    itemable_id: artwork.id)
                                  
              @recording.cover_art      = artwork.thumb
              @recording.image_file_id  = artwork.id
              @recording.save!
            end
          end 
        end
      end

      if @recording.in_bucket?
        redirect_to account_account_recordings_bucket_path(@account, @recording )
      else
        #redirect_to :back
        @recording.common_work.update_completeness if @recording.common_work
        redirect_to account_account_recording_path(@account, @recording )
      end
      
      #if @genre_category
      #  redirect_to edit_account_common_work_recording_path(@account, @common_work, @recording, genre_category: @genre_category )
      #else
      #  redirect_to account_common_work_recording_path(@account, @common_work, @recording, genre_category: @genre_category )
      #end

    else
      # jump back to recordings
      redirect_to_return_url account_account_recording_path(@account, @recording)
    end
  end

  
  def destroy
    @recording = Recording.find(params[:id])
    common_work = @recording.common_work
    @recording.destroy
    common_work.update_completeness if common_work
    # jump back to recordings or common work
    redirect_to_return_url account_account_recordings_path( @account, page: params[:page], query: params[:query])
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
      @recording.save
      @recording.common_work.update_completeness
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
      @recording.common_work.update_completeness
    end
    
  end

  def add_genre
    @blog           = Blog.recordings
    @recording      = Recording.find(params[:recording_id])
    if params[:recording]
      #@recording.category = params[:recording][:category]
      @recording.cache_version += 1
      @recording.save
      @recording.common_work.update_completeness
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
      @recording.common_work.update_completeness
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
  
  def find_in_bucket
    
  end
  
  def files
    forbidden unless current_account_user.read_recording
    #@recording      = Recording.cached_find(params[:id])
  end
  
  def documents
    forbidden unless current_account_user.read_recording
    @recording      = Recording.cached_find(params[:id])
  end
  
  def legal_documents
    forbidden unless current_account_user.read_recording
    @recording      = Recording.cached_find(params[:id])
  end
  
  def artwork
    forbidden unless current_account_user.read_recording
    @artwork = Artwork.new
  end
  
  
  def new_artwork
    forbidden unless current_account_user.read_recording
    @recording      = Recording.cached_find(params[:id])    
  end
  
  def create_artwork
    if params[:transloadit]
      if artworks = TransloaditImageParser.artwork( params[:transloadit], @account.id )
        artworks.each do |artwork|
          RecordingItem.create( recording_id: @recording.id, 
                                itemable_type: 'Artwork',
                                itemable_id: artwork.id)
        end
      end
    end
    redirect_to artwork_account_account_recording_path(@account, @recording)
  end
  
 
  
  # ====================================================
  # financial documents
  def financial_documents
    forbidden unless current_account_user.read_recording
    @recording      = Recording.cached_find(params[:id])
  end


 
    
  def download
    
    # this has to work with nginx
    # http://kovyrin.net/2010/07/24/nginx-fu-x-accel-redirect-remote/
    
    @recording = Recording.cached_find(params[:id])
    original_file_name = Pathname.new(@recording.mp3).basename 
    
  
    
    response.headers['Content-Type'] = 'audio/mp3'
    response.headers['Content-Disposition'] = "attachment; filename=#{original_file_name}"
    response.headers['Cache-Control'] =  "private"
    response.headers['X-Accel-Redirect'] = @recording.download_url
    render :nothing=>true
    
    # working but slow
    # AWS.config(access_key_id: 'AKIAJN4UDAY5IF3CRYDA',  secret_access_key: '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' ) 
    #send_data( 
    #
    #  AWS::S3.new.buckets['digiramp'].objects[@recording.mp3.gsub('http://digiramp.s3.amazonaws.com/', '')].read, {
    #    filename: original_file_name, 
    #    type: "audio/mp3", 
    #    disposition: 'attachment', 
    #    stream: 'true', 
    #    buffer_size: '4096'
    #  }
    #)
  end
    
    
    
    

  
  
private
  
  def recording_params
    params.require(:recording).permit!
  end
  
  
end
