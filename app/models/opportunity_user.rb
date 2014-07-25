class OpportunityUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :opportunity
end
