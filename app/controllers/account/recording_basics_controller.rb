class Account::RecordingBasicsController < ApplicationController
  
  include Transloadit::Rails::ParamsDecoder
  include RecordingsHelper
  include AccountsHelper
  before_action :access_account
  before_action :read_recording, only:[ :edit]
  
  def edit
    forbidden unless current_account_user.update_recording?
  end

  def update

    go_to = params[:recording][:next_step]
    params[:recording].delete :next_step

    @recording      = Recording.cached_find(params[:id])
    @account        = Account.cached_find(params[:account_id])
    
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
      @recording.check_default_image

      @recording.common_work.update_completeness if @recording.common_work
      
    end
    if go_to == 'next_step'
      redirect_to edit_account_account_recording_lyric_path( @account, @recording )
    else
      redirect_to account_account_recording_path( @account, @recording )
    end
  end
  
  

  
private

  def recording_params
    params.require(:recording).permit( RecordingParams::PARAMS )
  end
end
