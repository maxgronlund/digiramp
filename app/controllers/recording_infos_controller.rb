class RecordingInfosController < ApplicationController
  include AccountsHelper
  before_filter :access_account, only: [:show]
  before_filter :get_user, only: [ :edit, :update]
  include Transloadit::Rails::ParamsDecoder

  def show
    
    @common_work    = CommonWork.cached_find(params[:common_work_id])
    @recording      = Recording.cached_find(params[:id])
  end
  
  def edit
    @recording      = Recording.cached_find(params[:id])
    @user           = User.cached_find(params[:user_id])
  end
  
  def update



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
        if artworks = TransloaditImageParser.artwork( params[:transloadit], @user.account_id)
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


      @recording.common_work.update_completeness if @recording.common_work
      
    end
    redirect_to edit_user_recording_tag_path( @user, @recording )
  end
private

  def recording_params
    params.require(:recording).permit!
  end
end
