class CatalogsRecordings < ActiveRecord::Base
  belongs_to :catalog
  belongs_to :recording
end
