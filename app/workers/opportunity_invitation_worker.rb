class OpportunityInvitationWorker
  include Sidekiq::Worker
  
  def perform(email, opportunity_invitation_id, user_id, current_user_id)
    OpportunityMailer.invite(email, opportunity_invitation_id, user_id, current_user_id).deliver!
  end
end
