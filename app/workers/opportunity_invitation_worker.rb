class OpportunityInvitationWorker
  include Sidekiq::Worker
  
  def perform
    OpportunityMailer.invite()
  end
end