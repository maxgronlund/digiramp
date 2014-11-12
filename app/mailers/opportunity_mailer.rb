class OpportunityMailer < ActionMailer::Base
  default from: "info@digiramp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.opportunity_mailer.invite.subject
  #
  def invite email, opportunity_invitation_id, user_id, current_user_id
   
    @user                    = User.cached_find(user_id)
    @current_user_id         = current_user_id
    @opportunity_invitation  = OpportunityInvitation.cached_find(opportunity_invitation_id)
    @opportunity             = @opportunity_invitation.opportunity
    blog                     = Blog.cached_find('Support')
    @blog_post               = BlogPost.cached_find( "INVITE TO OPPORTUNITY" , blog )
    @opportunity_link        = url_for( controller: 'opportunity/opportunities', action: 'show', id: @opportunity.id)
    @fotter_link             = url_for( controller: 'contacts', action: 'new')
    
    mail to: email, subject: @opportunity_invitation.title
    
    store_mail 'opportunity invitation'
    #puts '----------------------- SUCCESS 33 -----------------------------'
  end
  
  def invite_to_account email, opportunity_invitation_id, user_id, current_user_id
    
    @user                    = User.cached_find(user_id)
    @current_user_id         = current_user_id 
    @opportunity_invitation  = OpportunityInvitation.cached_find(opportunity_invitation_id)
    @opportunity             = @opportunity_invitation.opportunity
    blog                     = Blog.cached_find('Support')
    @blog_post               = BlogPost.cached_find( "INVITE TO OPPORTUNITY" , blog )
    @opportunity_link        = url_for( controller: 'activate_account', action: 'edit', id: @user.password_reset_token, opportunity_id: @opportunity.id  )
    @fotter_link             = url_for( controller: 'contacts', action: 'new')

    mail to: email, subject: @opportunity_invitation.title
    store_mail 'account and opportunity invitation'
   
  end
  
  def store_mail email_type

    email = Email.create(      email: @user.email, 
                          email_type: email_type,
                             user_id: @current_user_id,
                     send_to_user_id: @user.id,
                          account_id: @opportunity.account_id,
                        content_type: @opportunity_invitation.class.name,
                             content: @opportunity_invitation.attributes
                )
    
    email.create_activity(:created, 
                              owner: User.cached_find(@current_user_id),
                          recipient: @user,
                     recipient_type: @user.class.name,
                         account_id: @user.account_id,
                                    params: { opportunity_id: @opportunity.id}) 
                                    
    
  end
  
  
end
  