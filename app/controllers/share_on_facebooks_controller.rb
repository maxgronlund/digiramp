class ShareOnFacebooksController < ApplicationController

  
  def create
    #ap '-------------- ShareOnFacebooksController -----------'
    #ap params
    #ap 'check if there is a current user'
    if current_user
      if current_user.facebook_publish_actions
        
        ap 'ohay everything is cool '
        @recording  = Recording.cached_find(params[:share_on_facebook][:recording_id])
        @user       = User.cached_find(params[:share_on_facebook][:user_id])
        @recording_id = @recording.id
        @share_on_facebook = ShareOnFacebook.new(share_on_facebook_params)
        if @share_on_facebook.save
          FbRecordingCommentWorker.perform_async(@share_on_facebook.id)
      
          # add a comment
          if @comment = Comment.create!(commentable_id: @recording.id, commentable_type: "Recording", user_id: @user.id, body: "I just shared #{@recording.title} on Facebook" )
      
           @comment.user.create_activity(  :created, 
                              owner: @comment,
                          recipient: @comment.commentable,
                     recipient_type: @comment.commentable.class.name,
                         account_id: @comment.user.account_id)
            
            Activity.notify_followers(  'Posted a comment on', @user.id, 'Recording', @recording.id )
          end 
          
          #go_to = session[:share_from_page]
          #session[:share_from_page] = nil
          #redirect_to go_to
        end
      elsif current_user.facebook
        # 'publish actions is not granded'
        # 'remove bad provider'
        provider = current_user.authorization_providers.where(provider: 'facebook').first
        provider.destroy
        
        # bounce back and share after creating fb provider
        session[:current_page] = share_on_facebook_path(params[:share_on_facebook][:user_id], params[:share_on_facebook])
        @redirect = true
        # recreate provider
        #session[:current_page] = session[:share_from_page]
        #redirect_to "/auth/facebook", format: "html"
        
        
        
      else
        # the user is not linked with facebook
        #ap '>>>>>>>>>>>>>>>>> link user with facebook: to do bounce back <<<<<<<<<<<<<<<<<<<<<<<<<'
        session[:current_page] = share_on_facebook_path(params[:share_on_facebook][:user_id], params[:share_on_facebook])
        @redirect = true
        #redirect_to "/auth/facebook", format: "html"
      end
      #ap '======= user signed in ========='
      #
      #if current_user.facebook
      #  ap 'user is linked with facebook'
      #  ap current_user.facebook
      #else
      #  ap 'link user with facebook: to do bounce back'
      #  session[:current_page] = share_on_facebook_path(params[:share_on_facebook][:user_id], params[:share_on_facebook])
      #  redirect_to "/auth/facebook"
      #end
    else
      #ap ' ========== user not signed in: sign in with facebook ========='
      #ap ' if signin with facebook fails handle that gracefully ========='
      session[:current_page] = share_on_facebook_path(params[:share_on_facebook][:user_id], params[:share_on_facebook])
      @redirect = true
      #redirect_to "/auth/facebook", format: "html"
    end

  end
  
  def show
    
    ap params
    
    recording  = Recording.cached_find(params[:recording_id])
    user       = User.cached_find(params[:user_id])
    share_on_facebook = ShareOnFacebook.new(user_id: user.id, recording_id: recording.id, message: params[:message])
    if share_on_facebook.save
      FbRecordingCommentWorker.perform_async(share_on_facebook.id)
      
      # add a comment
      if @comment = Comment.create!(commentable_id: recording.id, commentable_type: "Recording", user_id: user.id, body:  "I just shared #{recording.title} on Facebook" )
  
       @comment.user.create_activity(  :created, 
                          owner: @comment,
                      recipient: @comment.commentable,
                 recipient_type: @comment.commentable.class.name,
                     account_id: @comment.user.account_id)
      end 
      
      
    end
    
    go_to = session[:share_from_page]
    session[:share_from_page] = nil
    redirect_to go_to
    
  end

 

private
  def share_on_facebook_params
    params.require(:share_on_facebook).permit(:user_id, :recording_id, :message)
  end
end
