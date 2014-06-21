class Catalog::RecordingsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  #include RecordingsHelper
  include AccountsHelper
  include CatalogsHelper
  before_filter :access_account
  before_filter :access_catalog
  #before_filter :read_recording, only:[:show]
  
  def index
    @recordings      = Recording.catalogs_search( @catalog.recordings , params[:query]).order('title asc').page(params[:page]).per(24)
  end
  
  def info
    @recording   = Recording.cached_find(params[:recording_id])
  end

  def show
    @recording      = Recording.cached_find(params[:id])
  end
  
  def edit
    forbidden unless current_catalog_user.update_recording?
    
    @recording      = Recording.find(params[:id])
    
    @recording.genre        = @recording.genre_tags_as_csv_string
    @recording.instruments  = @recording.instruments_tags_as_csv_string
    @recording.mood         = @recording.moods_tags_as_csv_string
    
    #@recording.copy_genre_tags_in_to_genre_string
    #if params[:genre_category]
    #  redirect_to account_common_work_recording_genre_tags_path(@account, @common_work, @recording, genre_category: params[:genre_category])
    #end
  end
  
  def new
    forbidden unless current_catalog_user.create_recording?
    @common_work    = CommonWork.cached_find(params[:common_work_id])
    @recording      = Recording.new
  end
  
  # return from transloadit
  def create
    forbidden unless current_catalog_user.create_recording?
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
    
    forbidden unless current_catalog_user.update_recording?
    #@catalog        = Catalog.find(params[:catalog_id])
    @recording      = Recording.find(params[:id])
    
    
    params[:recording][:uuid] = UUIDTools::UUID.timestamp_create().to_s

    if @genre_category = params[:recording][:genre_category]
      params[:recording].delete :genre_category
    end
    
    params[:recording].delete :catalog_id
    
    if @recording.update_attributes(recording_params)
      @recording.extract_genres
      @recording.extract_instruments
      @recording.extract_moods

      
      # artwork
      if artworks = TransloaditImageParser.catalog_artwork( params[:transloadit], @account.id, @catalog.id )
        # if there is no artwork file
        if artworks == []
          # if a drop down item is selected
          begin
            artwork = Artwork.cached_find(params[:recording][:image_file_id])
            @recording.cover_art  = artwork.thumb
            @recording.save!
          rescue
          end
        else
          # add the uploaded artwork
          # notice there is only one artwork file
          artworks.each do |artwork|
            CatalogItem.create( catalog_id: @catalog.id, 
                                catalog_itemable_type: 'Artwork',
                                catalog_itemable_id: artwork.id)
                                
                                
                                
            RecordingItem.create( recording_id: @recording.id, 
                                  itemable_type: 'Artwork',
                                  itemable_id: artwork.id)
                                
            @recording.cover_art      = artwork.thumb
            @recording.image_file_id  = artwork.id
            @recording.save!
          end
        end 
      end
      
      
      @recording.common_work.update_completeness
      flash[:info]      = { title: "Success", body: "Recording updated" }

    else
      flash[:danger]      = { title: "Sorry", body: "Unable to update recording" }
    end
    redirect_to catalog_account_catalog_recording_path(@account, @catalog, @recording )
  end

  
  def destroy
    forbidden unless current_catalog_user.delete_recording
    @recording = Recording.find(params[:id])
    common_work = @recording.common_work
    @recording.destroy
    common_work.update_completeness
    # jump back to recordings or common work

    if session[:after_delete_recording]
      redirect_to session[:after_delete_recording]
    else
      redirect_to_return_url catalog_account_catalog_recordings_path(@account, @catalog, page: params[:page], query: params[:query])
    end
    
  end
  
  # after recordings returns from transloadet
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
    
    @catalog.count_recordings                       
  end
  
  
  def artwork
    @recording          = Recording.cached_find(params[:recording_id])
    
  end
  
  
  def select_category
    @blog               = Blog.recordings
    @recording          = Recording.cached_find(params[:recording_id])

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
  
  # catalog users can select artwork for a recording
  # from the catalogs artwork repository
  def new_from_catalog_artworks
    forbidden unless current_catalog_user.read_file
    @recording      = Recording.find(params[:recording_id])
  end
  
  # create a new recording_item holding a 'Artwork' for a recording
  def create_from_catalog_artworks

    forbidden unless current_catalog_user.update_file
    @recording      = Recording.find(params[:recording_id])
    @remove_tag = "#artwork_#{params[:artwork_id]}"
    
    
    RecordingItem.where(  recording_id: @recording.id,
                          itemable_id: params[:artwork_id],
                          itemable_type: 'Artwork'
                        )
                  .first_or_create(  recording_id: @recording.id,
                                     itemable_id: params[:artwork_id],
                                     itemable_type: 'Artwork'
                                   )
    
  end
  
  def use_artwork
    forbidden unless current_catalog_user.update_file
    @recording          = Recording.find(params[:recording_id])
    artwork = Artwork.cached_find(params[:artwork_id])
    #puts '--------------------------------------------'
    #puts artwork.thumb
    @recording.cover_art = artwork.thumb
    @recording.save!
    #puts '--------------------------------------------'
    
    
    
    
    @remove_button      = "#remove_button_#{params[:artwork_id]}"
    @add_button         = "#add_button_#{params[:artwork_id]}"
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
