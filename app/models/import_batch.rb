class ImportBatch < ActiveRecord::Base
  belongs_to :account
  has_many :recordings
end
