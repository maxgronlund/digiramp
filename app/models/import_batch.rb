# encoding: UTF-8
class ImportBatch < ActiveRecord::Base
  belongs_to :account
  has_many :recordings
  
  serialize :transloadit
  mount_uploader :csv_file , CsvUploader
  


  
  def works
    common_works = []
    self.recordings.each do |recording|
      common_works << recording.common_work
    end
    common_works
  end
  
  
end
