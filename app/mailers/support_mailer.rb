class SupportMailer < ActionMailer::Base
  default from: "info@digiramp.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.support_mailer.ticket_created.subject
  #
  def ticket_received user_id,  issue_id, blog_post_id
    @user      = User.cached_find user_id
    @issue     = Issue.cached_find issue_id
    @blog_post = BlogPost.find( blog_post_id )
    @body      = @blog_post.body.gsub( '--user--', @user.name)
    mail to: @user.email,  subject: @blog_post.title
  end
  
  def ticket_created
    @greeting = "Hi"

    mail to: @user.email,  subject: title
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.support_mailer.comment_posted.subject
  #
  def comment_posted
    @greeting = "Hi"

    mail to: @user.email,  subject: title
  end
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.support_mailer.issue_closed.subject
  #
  def issue_resolved user_id,  issue_id

    @user       = User.cached_find user_id
    @issue      = Issue.cached_find issue_id
    #@blog_post  = BlogPost.find( blog_post_id )
    #@body       = @blog_post.body.gsub( '--user--', @user.name)
    #@body       = @body.gsub('--issue--', @issue.title)
    
  
    mail to: @user.email,  subject: @blog_post.title
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.support_mailer.issue_closed.subject
  #
  def issue_closed
    @greeting = "Hi"

    mail to: @user.email,  subject: title
  end
  
  def contact contact_id
    
    @contact = Contact.cached_find(contact_id)
    mail to: 'support@digiramp.com', subject: "Support ticket ##{@contact.id}"
  end
end

#SupportMailer.contact