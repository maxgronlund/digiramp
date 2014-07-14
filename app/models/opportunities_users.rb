class OpportunitiesUsers < ActiveRecord::Base
  belongs_to :opportunity
  belongs_to :user
end
