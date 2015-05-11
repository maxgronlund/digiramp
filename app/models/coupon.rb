class Coupon < ActiveRecord::Base
  #belongs_to :user
  belongs_to :account
  belongs_to :plan
  has_many :subscriptions
  
  serialize :stripe_object, Hash
  
  DURATION = ['forever', 'once', 'repeating']
  
  #def self.get_code stripe_id
  #  if !stripe_id.blank?
  #    if coupon =  Coupon.find_by(stripe_id: stripe_id)
  #      return coupon.stripe_object
  #    end
  #  end
  #  return nil
  #end
end

