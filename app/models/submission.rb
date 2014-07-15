class Submission < ActiveRecord::Base
  belongs_to :opportunity
  belongs_to :account
  belongs_to :user
  belongs_to :recording
end
