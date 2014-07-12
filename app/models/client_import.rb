class ClientImport < ActiveRecord::Base
  belongs_to :account
  
  mount_uploader :file , CsvUploader
end
