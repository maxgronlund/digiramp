class Account::MusicSubmissionsController < ApplicationController
  before_action :set_music_request_and_submission, only: [:index, :show, :new, :edit, :update, :destroy, :download]
  
  include AccountsHelper
  before_action :access_account
  
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
    
    if @opportunity.takes_more_submissions_from_the( current_user )
      do_submit_recording params
    else
      redirect_to account_account_opportunity_music_request_max_submissions_reached_path(
                                  @account, 
                                  @opportunity,
                                  @music_request)
    end
  end
  
  def do_submit_recording params
    
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
       
        
      if Rails.env.production?              
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
          message.title              = "A recording has been submitted to #{@opportunity.title}"
          message.body               = "A submission from #{user.user_name} has been made for the opportunity: #{@opportunity.title}/ request: #{@music_request.title}"
          message.subjectable_id     = @music_submission.id
          message.subjectable_type   = 'MusicSubmission'
          message.save!
          message.send_as_email
        end
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
    @user = current_user
    @takes_more_submissions = @opportunity.takes_more_submissions_from_the( current_user )

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
