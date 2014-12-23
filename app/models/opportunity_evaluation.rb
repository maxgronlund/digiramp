class OpportunityEvaluation < ActiveRecord::Base
  belongs_to :opportunity
  belongs_to :user
  
  before_create :init_fields
  
  validates_presence_of :emails, :subject
  
  
  def init_fields
    self.uuid = UUIDTools::UUID.timestamp_create().to_s
  end
  
  
end
