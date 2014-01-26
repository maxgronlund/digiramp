class Administration < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :account_catalog
end
