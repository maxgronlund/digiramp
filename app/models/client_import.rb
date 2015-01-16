class ClientImport < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  
  mount_uploader :file , CsvUploader
end
