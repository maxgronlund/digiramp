class CommentMailer < ApplicationMailer
  
  def notify_user comment_id
    return unless Rails.env.production?
    
    @comment           = Comment.cached_find comment_id 
    @commenter         = @comment.user
    @commenter_avatar  = ( URI.parse(root_url) + @commenter.image_url(:avatar_92x92) ).to_s
    @commenter_url     = url_for( controller: 'users', action: 'show', id: @commenter.slug)
    @commenter_url     = ( URI.parse(root_url) + @commenter_url ).to_s
    


    
    
    case @comment.commentable_type
    
    when 'User'
      @user             = User.cached_find( @comment.commentable_id )
      @title            = "#{@commenter.user_name} posted a comment on your profile"
      @recipient        = User.cached_find( @comment.commentable_id )
      @comment_page_url = url_for( controller: 'users', action: 'show', id: @recipient.slug)
      @comment_page_url = ( URI.parse(root_url) + @commenter_url ).to_s
      
    when 'Recording'
      @recording        = Recording.cached_find( @comment.commentable_id )
      @title            = "#{@commenter.user_name} posted a comment on #{@recording.title}"
      @recipient        = @recording.user
      @comment_page_url = url_for( controller: 'recordings', action: 'show', user_id: @commenter.slug, id: @recording.id)
      @comment_page_url = ( URI.parse(root_url) + @comment_page_url ).to_s
      
      
    when 'Playlist'
      @playlist        = Playlist.cached_find( @comment.commentable_id )
      @title            = "#{@commenter.user_name} posted a comment on #{@playlist.title}"
      @recipient        = @playlist.user
      @comment_page_url = url_for( controller: 'playlists', action: 'show', user_id: @commenter.slug, id: @playlist.id)
      @comment_page_url = ( URI.parse(root_url) + @comment_page_url ).to_s
      
    end
    
    send_to_user if @title
    
    
  end
  
  private
  
  
  def send_to_user

    # perform 
    begin
      template_name = "comment-notification"
      template_content = []
      message = {
        to: [{email: @recipient.email , name: @recipient.user_name }],
        from: {email: "noreply@digiramp.com"},
        subject: @title,
        tags: ["personal-message", "comment-notification"],
        track_clicks: true,
        track_opens:  true,
        subaccount:   @commenter.mandrill_account_id,
        recipient_metadata: [{rcpt: @recipient.email, values: {comment_id: @comment.id}}],
        merge_vars: [
          {
           rcpt: @recipient.email,
           vars: [
                   {name: "SENDER_NAME",        content: @commenter.user_name},
                   {name: "TITLE",              content: @title},
                   {name: "COMMENT_PAGE_URL",   content: @comment_page_url},
                   {name: "AVATAR_URL",         content: @commenter_avatar},
                   {name: "SENDER_URL",         content: @commenter_url},
                   {name: "PROFESION",          content: @commenter.profession},
                   {name: "SHORT_DESCRIPTION",  content: @commenter.short_description},
                   {name: "WRITER",             content: @commenter.writer},
                   {name: "AUTHOR",             content: @commenter.author},
                   {name: "PRODUCER",           content: @commenter.producer},
                   {name: "COMPOSER",           content: @commenter.composer},
                   {name: "REMIXER",            content: @commenter.remixer},
                   {name: "MUSICIAN",           content: @commenter.musician},
                   {name: "DJ",                 content: @commenter.dj},
                   {name: "ARTIST",             content: @commenter.artist}
                 ]
          }
        ]
      }
      mandril_client.messages.send_template template_name, template_content, message
    rescue Mandrill::Error => e
      Opbeat.capture_message("#{e.class} - #{e.message}")
    end
    
    
    
    
  end
  
  
  
  
  
  
end
