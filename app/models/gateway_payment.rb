class GatewayPayment < ActiveRecord::Base
  belongs_to :stake
  default_scope -> { order('created_at ASC') }

  
end
