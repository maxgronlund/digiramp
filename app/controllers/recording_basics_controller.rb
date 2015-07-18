class RecordingBasicsController < ApplicationController
  include Transloadit::Rails::ParamsDecoder
  
  before_action :get_user, only: [ :edit, :update]
  include RecordingsHelper
  before_action :update_user_recording, only: [ :edit, :update]
  
  def edit
    
    #@user           = User.cached_find(params[:user_id])
    #@recording      = Recording.cached_find(params[:id])
    

    forbidden unless (current_user && @recording.user_id == current_user.id) || super?
    @common_work = @recording.common_work
    
  end

  def update

    @recording      = Recording.find(params[:id])
    
    if params[:recording][:featured] == '1' && @recording.featured == false
      params[:recording][:featured_date] = DateTime.now
    end

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
        if artworks = TransloaditImageParser.artwork( params[:transloadit], @user.account.id)
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
      @recording.check_default_image

      @recording.common_work.update_completeness if @recording.common_work
      
    end

    if @recording.privacy == 'Only people I choose'
      redirect_to user_user_recording_recording_users_path(@user, @recording)
    else
      redirect_to edit_user_recording_lyric_path( @user, @recording )
    end

  end
  
  

  
private

  def recording_params
    params.require(:recording).permit( RecordingParams::PARAMS )
  end
end
