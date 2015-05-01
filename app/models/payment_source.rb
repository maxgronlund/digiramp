class PaymentSource < ActiveRecord::Base
  has_paper_trail
  belongs_to :subscription
  serialize :stripe_data, Hash
end
