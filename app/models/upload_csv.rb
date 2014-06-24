class UploadCsv < ActiveRecord::Base
  belongs_to :account
  belongs_to :catalog
end
