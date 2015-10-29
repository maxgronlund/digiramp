class CommonWorkUser < ActiveRecord::Base
  belongs_to :common_work
  belongs_to :user
end
