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
    #url                     = url_for controller: 'account/opportunities', action: 'show', id: opportunity.id
    @opportunity_link       = view_context.link_to("click here", opportunity_opportunity_path(opportunity))
    puts '-------------------------------- +++++++++++++++++++++++++ ---------------------------------'
    puts @opportunity_link
    puts email
    @invitation             = opportunity_invitation.body
    #@footer     = footer.body.gsub('--link--', "<a href='#{url}'>Show Opportunity</a>")
    
    
    
    
    #

    mail to: email, subject: opportunity_invitation.title
  end
end
