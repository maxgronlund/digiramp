class ShareOnFacebooksController < ApplicationController

  # the user is sharing from the dialog
  def create
    # '-------------- ShareOnFacebooksController#create -----------'
    
    if current_user
      share_when_logged_in params
    else
      # there is a user but the user is not / linked with facebook 
      if params[:id]
        # go to ShareOnFacebooksController # show after authorizing
        session[:current_page] = share_on_facebook_path(params[:share_on_facebook][:user_id], params[:share_on_facebook])
        @authorize_facebook = true
      
      
      else
        ##'no user, no user_id we are not logged in/ signed up'
        session[:share_recording_id] = params[:share_on_facebook][:recording_id]
        session[:message]            = params[:share_on_facebook][:message]
        @authorize_facebook = true
      end
    end

  end
  
  
  # the user is logged in
  def share_when_logged_in params

    # if the publish action works
    if current_user.facebook_publish_actions
      share_with_authorized_user params
    
    # the user is linked with facebook but the authorization is broken  
    elsif current_user.facebook
      get_new_authorization params
   
    # the user is not linked with facebook
    else
      session[:current_page]      = share_on_facebook_path(params[:share_on_facebook][:user_id], params[:share_on_facebook])
      @authorize_facebook         = true
    end
  end
  
  
  
  
  def share_with_authorized_user params
  
    # '-------------- ShareOnFacebooksController#share_with_authorized_user -----------'
    # ohay everything is cool we are calle with ajax
    @recording  = Recording.cached_find(params[:share_on_facebook][:recording_id])
    @user = current_user
    @recording_id = @recording.id
    # error here user_id not saved
    @share_on_facebook = ShareOnFacebook.new(share_on_facebook_params)
    
    if @share_on_facebook.save
      FbRecordingCommentWorker.perform_async(@share_on_facebook.id)
  
      # add a comment
      if @comment = Comment.create!(commentable_id: @recording.id, commentable_type: "Recording", user_id: @user.id, body: "I just shared #{@recording.title} on Facebook" )
  
       @comment.user.create_activity(  :created, 
                          owner: @comment,
                      recipient: @comment.commentable,
                 recipient_type: @comment.commentable.class.name,
                     account_id: @comment.user.account.id)
        
        Activity.notify_followers(  'Posted a comment on', @user.id, 'Recording', @recording.id )
      end 
    end
  end
  
  
  

  # getting a new authorization from facebook
  def get_new_authorization params
    # '-------------- ShareOnFacebooksController#get_new_authorization -----------'
    provider            = current_user.authorization_providers.where(provider: 'facebook').first
    provider.destroy
    
    # go to show action after getting the new authorization
    session[:current_page]  = share_on_facebook_path(params[:share_on_facebook][:user_id], params[:share_on_facebook])
    @authorize_facebook     = true
    
    
    
  end
  
  
  
  # used when there is a full page reload after signing in / up with facebook
  def show
    # params
    # '-------------- ShareOnFacebooksController#show called after authorizing facebook -----------'

    
    
    recording  = Recording.cached_find(params[:recording_id])
    user = current_user

    
    message    = ''
    if session[:message]  
      message = session[:message]  
      session[:message]  = nil
    elsif params[:message] 
      message = params[:message] 
    end
    
    share_on_facebook = ShareOnFacebook.new(user_id: user.id, recording_id: recording.id, message: message)
    if share_on_facebook.save
      FbRecordingCommentWorker.perform_async(share_on_facebook.id)
      
      # add a comment
      if @comment = Comment.create!(commentable_id: recording.id, commentable_type: "Recording", user_id: user.id, body:  "I just shared #{recording.title} on Facebook" )
  
       @comment.user.create_activity(  :created, 
                          owner: @comment,
                      recipient: @comment.commentable,
                 recipient_type: @comment.commentable.class.name,
                     account_id: @comment.user.account.id)
        Activity.notify_followers(  'Posted a comment on', user.id, 'Recording', recording.id )
      end 
      
      
    end
    # a little clumpcy, might be better to bounch to the recording page
    # best would be to recunstruct scroll state but I'm not sure it's possible
    # at least search and filter state should be reconstructed on the recordings page
    go_to = session[:share_from_page]
    session[:share_from_page] = nil
    redirect_to go_to
    
  end

 

private
  def share_on_facebook_params
    # FOUND ERROR HERE
    # user_id was not saved: called from line 57
    # look inside FbRecordingCommentWorker line 12
    params.require(:share_on_facebook).permit!
    
    # bommer here : not permiting user_id
    #params.require(:share_on_facebook).permit(:recording_id, :message)
  end
end
