# Preview all emails at http://localhost:3000/rails/mailers/opportunity_mailer
class OpportunityMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/opportunity_mailer/invite
  def invite
    OpportunityMailer.invite
  end

end
