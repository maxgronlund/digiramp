class Stake < ActiveRecord::Base
  belongs_to :account
  belongs_to :asset, polymorphic: true
  has_paper_trail
  
  
  
  
end
