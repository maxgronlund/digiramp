class StripeCustomer < ActiveRecord::Base
  
  serialize :metadata, Hash
  serialize :subscriptions, Hash
  serialize :discount, Hash
  serialize :sources, Hash
  has_paper_trail
  
end
