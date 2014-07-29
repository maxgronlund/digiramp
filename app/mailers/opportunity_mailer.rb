class OpportunityMailer < ActionMailer::Base
  default from: "info@digiramp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.opportunity_mailer.invite.subject
  #
  def invite email, opportunity_invitation_id

    opportunity_invitation  = OpportunityInvitation.cached_find(opportunity_invitation_id)
    opportunity             = opportunity_invitation.opportunity
    blog                    = Blog.cached_find('Support')
    footer                  = BlogPost.cached_find( "INVITE TO OPPORTUNITY" , blog )

    @opportunity_link       = url_for( controller: 'opportunity/opportunities', action: 'show', id: opportunity.id)
    @invitation             = opportunity_invitation.body
    @footer                 = footer.body
    

    mail to: email, subject: opportunity_invitation.title
  end
  
  def invite_to_account email, opportunity_invitation_id, user_id
    
    puts '------------------------------------------------'
    puts 'INVITE TO ACCOUNT'
    puts '-------------------------------------------------'
    
    user                      = User.cached_find(user_id)
    opportunity_invitation  = OpportunityInvitation.cached_find(opportunity_invitation_id)
    opportunity             = opportunity_invitation.opportunity

    @opportunity_link       = url_for( controller: 'activate_account', action: 'edit', id: user.password_reset_token, opportunity_id: opportunity.id  )
    @invitation             = opportunity_invitation.body
    #@footer                 = footer.body
    

    mail to: email, subject: opportunity_invitation.title
  end
end
