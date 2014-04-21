# encoding: UTF-8
class ImportBatch < ActiveRecord::Base
  belongs_to :account
  has_many :recordings
  
  serialize :transloadit
  mount_uploader :csv_file , CsvUploader
  
  after_commit :flush_cache
  


  
  def works
    common_works = []
    self.recordings.each do |recording|
      common_works << recording.common_work
    end
    common_works
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  
end
