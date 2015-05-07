class PaymentSource < ActiveRecord::Base
  has_paper_trail
  belongs_to :subscription
  serialize :stripe_data, Hash
  
  before_destroy :cancel_subscription
  
  def cancel_subscription
    if self.subscription
      subscription.reset_state
      self.subscription.cancel_when_plan_expires
    end
  end
end
