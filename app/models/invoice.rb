class Invoice < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  
  serialize :lines, Hash
  serialize :discount, Hash
  serialize :metadata, Hash
end
