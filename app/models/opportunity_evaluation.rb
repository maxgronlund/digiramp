class OpportunityEvaluation < ActiveRecord::Base
  belongs_to :opportunity
  belongs_to :user
  
  before_create :init_fields
  after_create :init_users
  
  validates_presence_of :emails, :subject
  
  
  def init_fields
    self.uuid = UUIDTools::UUID.timestamp_create().to_s
  end
  
  def init_users
    self.emails.split(/, ?/).each do |email|
      
      sanitized_email =  EmailSanitizer.saintize email

      if user  = User.find_or_invite_from_email( sanitized_email )

        if user.account_activated
          OpportunityEvaluationMailer.delay.invite(user.id, self.id)
        else
          user.add_token
          OpportunityEvaluationMailer.delay.invite_to_account(user.id, self.id)
        end
        
       
        #@opportunity_user.create_activity(   :created, 
        #                               owner: current_user,
        #                           recipient: @opportunity_user,
        #                      recipient_type: @opportunity_user.class.name,
        #                          account_id: @account.id,
        #                              params: {         opportunity_id: @opportunity.id,
        #                                        opportunity_user_email: sanitized_email
        #                                      }
        #                                  ) 
                              
      end  
    end                
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  
end
