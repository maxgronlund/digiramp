class Account::OpportunityFromPlaylistsController < ApplicationController
  include AccountsHelper
  before_action :access_account
  def create

    if playlist_id = params[:opportunity][:playlist_id]
      params[:opportunity][:playlist_id] = nil
      @playlist = Playlist.cached_find(playlist_id)
      
      @opportunity = Opportunity.create(opportunity_params)
      
      opportunity_user = OpportunityUser.create(opportunity_id:   @opportunity.id, 
                                                user_id:          @opportunity.account.user_id,
                                                provider:         true,
                                                reviewer:         true,
                                                can_download:     true,
                                                uuid:             UUIDTools::UUID.timestamp_create().to_s
                                                )
      
      creat_music_request
      
    end
    
    #redirect_to opportunity_opportunity_reviewer_path(@opportunity, opportunity_user.uuid )
    #account/accounts/6/opportunities/147/opportunity_users
    redirect_to account_account_opportunity_opportunity_users_path(@account, @opportunity )
    
  end
  
  def new
    if user = @account.user
      @playlists = user.playlists
    end
    
    if playlist_id =  params[:playlist_id] 
      if playlist = Playlist.cached_find(playlist_id)
        @opportunity = Opportunity.new(playlist_id: playlist_id, title: playlist.title)
      end
    end
    @opportunity = Opportunity.new if @opportunity.nil? 
    @user = current_user
  end
  
  private
  
  def creat_music_request
    if @music_request = MusicRequest.create!(
                        opportunity_id: @opportunity.id,
                        title:          @opportunity.title,
                        body:           @opportunity.body
      )
      populate_musicrequest
    end
  end
  
  def populate_musicrequest
    @playlist.recordings.each do |recording|
      
      begin
        MusicSubmission.create(
            recording_id:     recording.id,
            music_request_id: @music_request.id,
            user_id:          @account.user_id,
            account_id:       @account.id,
            #opportunity_user: @account.user_id
          )
      rescue
      end
    end
  end

  
  # Never trust parameters from the scary internet, only allow the white list through.
  def opportunity_params
    #params.require(:opportunity).permit!
    params.require(:opportunity).permit(:title, 
                                        :body, 
                                        :kind, 
                                        :budget,
                                        :deadline,
                                        :account_id,
                                        :territory,
                                        :public_opportunity,
                                        :image,
                                        :max_submisions_pr_user,
                                        :playlist_id
                                        )
  end
  
end
