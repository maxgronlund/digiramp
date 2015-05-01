class Catalog::RecordingsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  #include RecordingsHelper
  include AccountsHelper
  include CatalogsHelper
  before_action :access_account
  before_action :access_catalog
  #before_action :read_recording, only:[:show]
  
  def index
    
    if @catalog_user = CatalogUser.where(catalog_id: @catalog.id, user_id: current_user.id).first
      @recordings   = Recording.not_in_bucket.catalogs_search( @catalog.recordings , params[:query]).order('title asc').page(params[:page]).per(24)
      @widget       = @catalog.default_widget  
      @playlists    = current_user.playlists
      @user         = current_user
      
      
      @authorized  = true
      #@query_string = '/digiwham/recordings/?key='  + @catalog.default_widget.secret_key
      #@query_string += '&catalog='                  + @catalog.uuid 
      #@query_string += '&catalog_user='             + @catalog_user.uuid   
      #@query_string += '&query=' + params[:query].to_s if params[:query]
    end
  end
  
  def info
    @recording   = Recording.cached_find(params[:recording_id])
  end

  def show
    @recording      = Recording.cached_find(params[:id])
    # activity logging
    @recording.create_activity(  :show, 
                       owner: current_user,
                   recipient: @recording,
              recipient_type: @recording.class.name,
                  account_id: @recording.account_id)
  end
  
  def edit
    forbidden unless current_catalog_user.update_recording?
    
    @recording      = Recording.find(params[:id])
    
    @recording.genre        = @recording.genre_tags_as_csv_string
    @recording.instruments  = @recording.instruments_tags_as_csv_string
    @recording.mood         = @recording.moods_tags_as_csv_string
    

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
      flash[:info]      =  "Recording added to Common Work" 
      redirect_to account_work_work_recordings_path(@account, @common_work )
    rescue
      flash[:danger]      =  "Please check if you selected a valid file" 
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
       
       # activity logging
       @recording.create_activity(  :updated, 
                          owner: current_user,
                      recipient: @recording,
                 recipient_type: @recording.class.name,
                     account_id: @recording.account_id)
      
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
              
              ArtworksCatalogs.where(artwork_id: artwork.id, catalog_id: @catalog.id)
                              .first_or_create(artwork_id: artwork.id, catalog_id: @catalog.id)
              
                                  
                                  
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
      
      
      @recording.common_work.update_completeness
      

    else
      flash[:danger]      =  "Unable to update recording" 
    end
    redirect_to catalog_account_catalog_recording_path(@account, @catalog, @recording )
  end

  
  def destroy
   
    forbidden unless current_catalog_user.delete_recording
    @recording  = Recording.find(params[:id])
    
    
   
    redirect_to :back

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
