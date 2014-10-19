class RecordingsController < ApplicationController
  before_filter :get_user, only: [:show, :edit, :update, :new, :create, :destroy, :index]
  include Transloadit::Rails::ParamsDecoder
  
  def index
    #@widget = @user.default_widget

    if  @user && @authorized
      @recordings =   Recording.recordings_search(@user.recordings, params[:query]).page(params[:page]).per(48)
    elsif @user
      #@recordings =  @user.recordings.published.recordings_search(@user.recordings, params[:query]).page(params[:page]).per(48)
      @recordings =  @user.recordings.recordings_search(@user.recordings, params[:query]).page(params[:page]).per(48)
    else
      @recordings =  Recording.recordings_search(Recording.all, params[:query]).page(params[:page]).per(48)
    end
  end
  
  def new
    @recording = Recording.new
  end
  
  def create
    
    result = TransloaditRecordingsParser.parse( params[:transloadit],  @user.account_id, false, @user.id)
    if result[:recordings].size != 0
      
      result[:recordings].each do |recording|
        
        #recording.create_activity(  :created, 
        #                          owner: current_user,
        #                      recipient: recording,
        #                 recipient_type: recording.class.name,
        #                     account_id: @user.account_id)
        #                     
        #                     
        current_user.create_activity(  :created, 
                                   owner: recording,
                               recipient: @user,
                          recipient_type: 'Recording',
                              account_id: current_user.account_id) 
                              
        
        common_work = CommonWork.create(account_id: recording.account_id, 
                                        title: recording.title, 
                                        lyrics: recording.lyrics)
        
        
        #common_work.create_activity(  :created, 
        #                          owner: current_user,
        #                      recipient: common_work,
        #                 recipient_type: common_work.class.name,
        #                     account_id: @user.account_id)
        #                     
        #                     
        recording.common_work_id = common_work.id
        recording.save
        recording.common_work.update_completeness
        @recording = recording

      end
      redirect_to edit_user_recording_path(@user, @recording)
    else
      flash[:error]      = { title: "Error", body: "Unable to upload recording" }
      render new
    end
  end
  
  def show
    @recording = Recording.find(params[:id])
    #@widget = @user.default_widget
    #@recordings = @widget.recordings
  end
  
  def destroy
    @recording = Recording.find(params[:id])
    common_work = @recording.common_work
    @recording.destroy
    common_work.update_completeness if common_work

    redirect_to user_recordings_path(@user)
  end
  
  def edit
    @recording = Recording.cached_find(params[:id])
    
    
  end
  
  #def update
  #  @recording                = Recording.find(params[:id])
  #  params[:recording][:uuid] = UUIDTools::UUID.timestamp_create().to_s
  #
  #  if @recording.update_attributes(recording_params)
  #     @recording.extract_genres
  #     @recording.extract_instruments
  #     @recording.extract_moods
  #     
  #     # artwork
  #     if params[:transloadit]
  #       if artworks = TransloaditImageParser.artwork( params[:transloadit], @account.id)
  #         # if there is no artwork file
  #         if artworks == []
  #           # if a drop down item is selected
  #           if params[:recording][:image_file_id].to_s != ''   
  #             artwork = Artwork.cached_find(params[:recording][:image_file_id])
  #             @recording.cover_art  = artwork.thumb
  #             @recording.save!
  #           end
  #         else
  #           # add the uploaded artwork
  #           # notice there is only one artwork file
  #           artworks.each do |artwork|
  #                                
  #             RecordingItem.create( recording_id: @recording.id, 
  #                                   itemable_type: 'Artwork',
  #                                   itemable_id: artwork.id)
  #                                
  #             @recording.cover_art      = artwork.thumb
  #             @recording.image_file_id  = artwork.id
  #             @recording.save!
  #           end
  #         end 
  #       end
  #     end
  #     
  #     
  #     
  #     
  #  end
  #  redirect_to user_recording_path( @user, @recording )
  #end
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
    redirect_to user_recording_path( @user, @recording )
  end
  
   
private

  def recording_params
    params.require(:recording).permit!
  end
end
