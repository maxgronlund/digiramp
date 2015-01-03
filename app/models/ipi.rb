class Ipi < ActiveRecord::Base
  
  has_many :activity_events, as: :activity_eventable
  
  belongs_to :common_work
  
  belongs_to :import_ipi
  belongs_to :user
  after_create :add_uuid
  
  after_commit :flush_cache
  


  ROLES = [ "Writer", "Composer", "Administrator", "Producer", "Original Publisher",  "Artist", "Distributor", "Remixer", "Other", "Publisher"]
  def add_uuid
    if self.uuid.to_s == ''
      self.uuid = UUIDTools::UUID.timestamp_create().to_s
      self.save!
    end
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  

private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end




