class Opportunity::RecordingsController < ApplicationController
  
  
  include ActionView::Helpers::TextHelper
  include Transloadit::Rails::ParamsDecoder
  include OpportunitiesHelper
  before_filter :access_opportunity
  
  def index
    @recordings = []
    begin
      if params[:query]
      
        @user                 = User.cached_find(params[:opportunity][:user_id])
        @opportunity          = Opportunity.cached_find(params[:opportunity_id])
        @music_request        = MusicRequest.cached_find(params[:opportunity][:music_request_id])
        
        user_recording_ids    = @user.recording_ids
        music_submission_ids  = MusicSubmission.where(id: @music_request.music_submission_ids).pluck(:recording_id)
        recording_ids         = user_recording_ids - music_submission_ids
        recordings            = Recording.where(id: recording_ids)
        
        @recordings           = Recording.recordings_search(recordings, params[:query]).order('uniq_title asc').page(params[:page]).per(4)
      else
        
        @user                 = User.cached_find(params[:user_id])                 
        @opportunity          = Opportunity.cached_find(params[:opportunity_id])
        @music_request        = MusicRequest.cached_find(params[:music_request_id])
        
        user_recording_ids    = @user.recording_ids
        music_submission_ids  = MusicSubmission.where(id: @music_request.music_submission_ids).pluck(:recording_id)
        recording_ids         = user_recording_ids - music_submission_ids
        @recordings           = Recording.where(id: recording_ids).order('uniq_title asc').page(params[:page]).per(4)
      
      end
    rescue
      
    end
    #.page(params[:page]).per(4)
  end
  
  # from pagination
  # Parameters: {"music_request_id"=>"4", "page"=>"3", "user_id"=>"1", "opportunity_id"=>"5"}
  
  
  # from a search
  #{
  #              "utf8" => "✓",
  #       "opportunity" => {
  #        "music_request_id" => "4",
  #                 "user_id" => "1"
  #    },
  #             "query" => "pop",
  #            "commit" => "Go",
  #            "action" => "index",
  #        "controller" => "opportunity/recordings",
  #    "opportunity_id" => "5",
  #       "transloadit" => nil
  #}
  
  
  
  
  # from direct link
  #{
  #    "music_request_id" => "4",
  #             "user_id" => "1",
  #              "action" => "index",
  #          "controller" => "opportunity/recordings",
  #      "opportunity_id" => "5",
  #         "transloadit" => nil
  #}
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  def create
    #forbidden unless current_account_user.create_recording

    @common_work    = CommonWork.cached_find(params[:common_work_id])
    @music_request  = MusicRequest.cached_find(params[:music_request_id])
    #begin
      result = TransloaditRecordingsParser.parse params[:transloadit],  @account.id, false, @account.user_id
      
      
      # success mesage
      unless result[:recordings].size == 0
        flash[:info]      =  "#{pluralize(result[:recordings].size, "File")} uploaded" 
      end
      # error messages
      unless result[:errors].size == 0
        errors     = ''
        nr_errors = 0
        result[:errors].each do |error|
          nr_errors += 1
          errors << error + '<br>'
        end
        flash[:danger]    =  errors 
      end
      
      

      redirect_to edit_opportunity_opportunity_music_request_common_work_recording_path(@opportunity, @music_request, @common_work, result[:recordings][0])

  end
  
  def edit
    @common_work    = CommonWork.cached_find(params[:common_work_id])
    @music_request  = MusicRequest.cached_find(params[:music_request_id])
    @recording      = Recording.cached_find(params[:id])
  end
  
  def update
    @common_work    = CommonWork.cached_find(params[:common_work_id])
    @music_request  = MusicRequest.cached_find(params[:music_request_id])
    @recording      = Recording.cached_find(params[:id])
    params[:recording][:uuid] = UUIDTools::UUID.timestamp_create().to_s



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
      
      
      @recording.common_work.update_completeness if @recording.common_work
      
      
      if opportunity_user = OpportunityUser.where(user_id: current_user.id, opportunity_id: @opportunity.id).first
      
        MusicSubmission.create( recording_id:         @recording.id, 
                                music_request_id:     @music_request.id, 
                                user_id:              current_user.id, 
                                opportunity_user_id:  opportunity_user.id,
                                account_id:           @recording.account_id
                              )
      end
    else
      
    end

    redirect_to opportunity_opportunity_music_request_path(@opportunity, @music_request)
  end
  
private



  def recording_params
    params.require(:recording).permit!
  end
end
