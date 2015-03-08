class OpportunityEvaluationMailer < ActionMailer::Base
  default from: "noreply@digiramp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.opportunity_evaluation_mailer.invite.subject
  #
  def invite user_id, opportunity_evaluation_id
    
    @opportunity_evaluation = OpportunityEvaluation.cached_find(opportunity_evaluation_id)
    @user                   = User.cached_find(user_id)
    

    mail to: @user.email, subject: @opportunity_evaluation.subject
  end
  
  def invite_to_account user_id, opportunity_evaluation_id
    @user                     = User.cached_find(user_id)
    @opportunity_evaluation   =        OpportunityEvaluation.cached_find(opportunity_evaluation_id)
    
    @opportunity_evaluation_link    = url_for( controller: 'opportunity/opportunities', action: 'show', id: @opportunity_evaluation.opportunity_id, opportunity_invitation: 'true', user_id: @user.id)
    @fotter_link                    = url_for( controller: 'contacts', action: 'new')
    
    

    mail to: @user.email,  subject: @opportunity_evaluation.subject
  end
end
