class RecordingSellection < ActiveRecord::Base
  belongs_to :recording_collection
  belongs_to :recording_collection_user
  belongs_to :recording
end
