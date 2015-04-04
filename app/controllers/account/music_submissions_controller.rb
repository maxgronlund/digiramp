class Account::MusicSubmissionsController < ApplicationController
  before_action :set_music_request_and_submission, only: [:index, :show, :new, :edit, :update, :destroy, :download]
  
  include AccountsHelper
  #before_filter :access_account
  before_filter :get_account_account
  
  #def index
  #  @recordings     = Recording.not_in_bucket.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(48)
  #end
  
  def new

    @recordings   = Recording.not_in_bucket.account_search(@account, params[:query]).order('title asc').page(params[:page]).per(48)
    @user         = current_user
    @music_request = MusicRequest.cached_find(params[:music_request_id])
  end
  
  
  
  def create
    
  end
  
  def create_comment
   @comment = Comment.create!(comment_params)
    redirect_to :back
    
  end
  
  def submit_recording
    @music_request       = MusicRequest.cached_find(params[:music_request_id])
    @opportunity         = Opportunity.cached_find(params[:opportunity_id])
    @opportunity_user    = OpportunityUser.where( opportunity_id: params[:opportunity_id], user_id: current_user.id ).first
    opportunity_user_id  = @opportunity_user ? @opportunity_user.id : nil
    

    
    if current_user && (@opportunity.public_opportunity || @opportunity_user)
      @recording        = Recording.cached_find(params[:id])
      
      @music_submission = MusicSubmission.where(  recording_id:         params[:id],
                                                  music_request_id:     params[:music_request_id],
                                                  account_id:          @account.id           
                                                )
                                          .first_or_create( 
                                                            recording_id:         params[:id],
                                                            music_request_id:     params[:music_request_id] ,
                                                            user_id:              current_user.id,
                                                            account_id:           @account.id,
                                                            opportunity_user_id:  opportunity_user_id
                                                            
                                                            
                                                          ) 
                          
      current_user.create_activity(  :created, 
                                owner: @recording,
                            recipient: @music_request,
                       recipient_type: 'MusicRequest',
                           account_id: @account.id)
       
                    
      channel = 'digiramp_radio_' + current_user.email
      Pusher.trigger(channel, 'digiramp_event', {"title" => 'RECORDING SUBMITTED', 
                                            "message" => "#{@recording.title} is submitted to #{@music_submission.music_request.title}", 
                                            "time"    => '4500', 
                                            "sticky"  => 'false', 
                                            "image"   => 'success'
                                            })
                                            
                                            
                                            
                                            
      if user = @opportunity.user
        message                    = Message.new
        message.recipient_id       = user.id
        message.sender_id          = current_user.id
        message.title              = 'I have submitted a recording'
        message.body               = "Thank's for the opportunity. I have submitted " + @opportunity.title + '. Please listen to it and see if you like it'
        message.subjectable_id     = @music_submission.id
        message.subjectable_type   = 'MusicSubmission'
        message.save!
        message.send_as_email
      end
        
      
      
    else
      channel = 'digiramp_radio_' + current_user.email
      Pusher.trigger(channel, 'digiramp_event', {"title" => 'YOU ARE NOT A MUSIC PROVIDERS', 
                                            "message" => 'Make sure you are on the list of authorized music providers', 
                                            "time"    => '2500', 
                                            "sticky"  => 'true', 
                                            "image"   => 'error'
                                            })
    end

  end

  def edit
  end

  def show
    @music_submission   = MusicSubmission.cached_find(params[:id])
    @recording          = @music_submission.recording
    @commentable        = @music_submission 
    @comments           = @commentable.comments 
    @comment            = Comment.new
    
  end

  def destroy
    #@music_submission  = MusicSubmission.cached_find(params[:id])
    #@music_submission.destroy!
    #redirect_to account_account_opportunity_music_request_path(@account, @opportunity, @music_request)
  end

  def update

  end
  
  def ratings
    
  end
  
  def download
    @music_submission   = MusicSubmission.cached_find(params[:id])
    @recording          = @music_submission.recording
  end
  
private

  def music_submission_params
     params.require(:music_submission).permit!
  end
  
  def comment_params
    params.require(:comment).permit!
  end
  
  # Use callbacks to share common setup or constraints between actions.
  def set_music_request_and_submission
    @music_request    = MusicRequest.cached_find(params[:music_request_id])
    @opportunity      = Opportunity.cached_find(params[:opportunity_id])
  end
  
  
end
