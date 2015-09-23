class Income < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :stake
end
