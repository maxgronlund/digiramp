class RecordingsController < ApplicationController
  
  #protect_from_forgery only: :show
  skip_before_action :verify_authenticity_token
  
  before_action :get_user, only: [ :show, :edit, :update, :new, :create, :destroy, :index]
  include Transloadit::Rails::ParamsDecoder


  def index
    if params[:commit] == 'Go'
      @remove_old_recordings = true
      session[:query] = params[:query]
    end
    
    session[:query] = nil if params[:clear] == 'clear'
    params[:query]  = session[:query]

    if (current_user && current_user.id == @user.id) || super?
      @recordings =  Recording.recordings_search(@user.recordings, params[:query])
                              .order('uniq_position desc')
                              .page(params[:page]).per(4)
    else
      @recordings =  Recording.recordings_search(@user.recordings, params[:query])
                              .public_access
                              .order('uniq_position desc')
                              .page(params[:page]).per(4)
    end
    @playlists  = current_user.playlists if current_user
  end
  


  def new
    @recording = Recording.new
  end

  def create
    
    result = TransloaditRecordingsParser.parse( params[:transloadit],  @user.account.id, false, @user.id)
   
    
    if result[:recordings].size != 0
      
      result[:recordings].each do |recording|     
        current_user.create_activity(  :created, 
                                   owner: recording,
                               recipient: @user,
                          recipient_type: 'Recording',
                              account_id: current_user.account.id) 
                              
        
        recording.mount_common_work

        if last_recording = @user.recordings.order('position asc').last
          begin
            recording.position = last_recording.position + 100
          rescue
          end
        end
        
        recording.privacy = params[:recording][:privacy]
        recording.save(validate: false)
        recording.check_default_image
        recording.get_common_work.update_completeness
        @recording = recording
        
        ###
        @recording.notify_followers
      end
      
      redirect_to edit_user_recording_basic_path(@user, @recording)
    else
      flash[:danger]      = result[:errors]
      redirect_to new_user_recording_path(@user)
    end
  end
  
  # also called from the play button
  def show

    return not_found unless  @recording = Recording.cached_find(params[:id])

    @common_work  = @recording.get_common_work
    @playlists    = current_user.playlists if current_user
    @user_credits = @recording.user_credits
    
    unless request.xhr?
      begin
        user_id = current_user ? current_user.id : nil
        RecordingView.create( recording_id: @recording.id, 
                               user_id: user_id, 
                               account_id: @recording.account_id 
                             )
      rescue
      end
    end
    respond_to do |format|
      format.html{ 
        case @recording.privacy
        when 'Only me'  
          return forbidden unless  (current_user && @recording.user_id == current_user.id) || super?
        when 'Only people I choose'
          if current_user
            return forbidden unless RecordingUser.find_by(user_id: current_user.id, recording_id: @recording.id) ||
                                                  (@recording.user_id == current_user.id) ||
                                                  super?
              
              
            
          else
            return forbidden
          end
        when 'Anyone'
          
        end

      }
      format.js
      format.json { render :json => @this.to_json }
    end
  end
  
  def destroy
    @recording_id = params[:id]
    @recording    = Recording.find(@recording_id)

    common_work = @recording.get_common_work
    
    
    #@recording.destroy
    @recording.user_id    = User.system_user.id
    @recording.account_id = User.system_user.account.id
    @recording.privacy    = 'Only me'
    @recording.remove_from_collections
    @recording.save(validate: false)
    
    
    
    common_work.update_completeness if common_work
    
    unless params[:public]
      redirect_to user_recordings_path(@user)
    end
  end
  
  def edit
    @recording = Recording.cached_find(params[:id])
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

      @recording.get_common_work.update_completeness
      
    end
    redirect_to user_recording_path( @user, @recording )
  end
  
  def rezip
    logger.info '--------------------------- reziping -----------------------------------'
    ZipRecordingsWorker.perform_async()
    #recordings = Recording.where(zipp: nil).first(10)
    #
    #if recordings
    #  recordings.each do |recording|
    #    recording.zip
    #  end
    #end
    
    render nothing: true
  end
  
   
private

  def recording_params
    params.require(:recording).permit( RecordingParams::PARAMS )
  end
end
