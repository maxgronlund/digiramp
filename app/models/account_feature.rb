class AccountFeature < ActiveRecord::Base
  
  has_many :accounts
  belongs_to :plan
  
  def name
    plan ? plan.name : account_type
  end
  
  def price
    plan ? plan.amount*0.01 : nil
  end
  
  def interval
    plan ? plan.interval : ''
  end
  
  
end
