class LikesController < ApplicationController
  before_action :get_user
  
  def index

    #if params[:recording_id]
    #  redirect_to user_recording_recording_likes_path( @user, params[:recording_id])
    #else
      recording_ids = Like.order('created_at desc').where(user_id: @user.id).pluck(:recording_id)
      @show         = 'what the user likes'
      @songs        = Recording.where(id: recording_ids).page(params[:page]).per(4)
      @playlists    = current_user.playlists if current_user
      #end
  end
  
  
  # This is called when a user click on the like button and it's not active
  # The users followers are notified
  # button is replaced using jquery
  def new
    user = User.friendly.find(params[:user_id])
    
    like = Like.where(
                        user_id: user.id,
                        recording_id: params[:recording_id],
                        )
                .first_or_create(
                        user_id: user.id,
                        recording_id: params[:recording_id],
                        account_id: user.account.id
                        )
    recording    = Recording.cached_find(params[:recording_id])
    recording.update(uniq_likes_count:  recording.likes.count.to_uniq)
   

             
    @unlike = '.unlike_recording_' + params[:recording_id].to_s   
    @like   = '.like_recording_'   + params[:recording_id].to_s 
    
    #recording.notify_followers 'Like this', @user.id, 'Recording', recording
    Activity.notify_followers(  'Like this', @user.id, 'Recording', recording.id )

    
  end
  
  def show
    
  end
  
  # This is called when a user click on the like button and it is activated
  def destroy
    user          = User.friendly.find(params[:user_id])
    like          = Like.where(user_id: user.id, recording_id: params[:id]).first   
    like.destroy 
    recording     = Recording.cached_find(params[:id])
    recording.update(uniq_likes_count:  recording.likes.count.to_uniq)

    @unlike = '.unlike_recording_'  + params[:id].to_s   
    @like   = '.like_recording_'    + params[:id].to_s  

  end
  
  private
  

end


