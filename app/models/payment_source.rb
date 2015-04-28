class PaymentSource < ActiveRecord::Base
  belongs_to :subscription
  
  serialize :stripe_data, Hash
end
