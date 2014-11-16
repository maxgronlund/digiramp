class RecordingView < ActiveRecord::Base
  belongs_to :user
  belongs_to :recording
  belongs_to :account
end
