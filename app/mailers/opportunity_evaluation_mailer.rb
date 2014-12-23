class OpportunityEvaluationMailer < ActionMailer::Base
  default from: "info@digiramp.com"

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
  
  def invite_to_account
    

    mail to: "to@example.org"
  end
end
