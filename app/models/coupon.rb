class Coupon < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :plan
  
  DURATION = ['forever', 'once', 'repeating']
end

