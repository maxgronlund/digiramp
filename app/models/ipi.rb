class Ipi < ActiveRecord::Base
  
  has_many :activity_events, as: :activity_eventable
  
  belongs_to :common_work
  
  belongs_to :import_ipi
  belongs_to :user
  
  after_commit :flush_cache
  


  ROLES = [ "Writer", "Composer", "Administrator", "Producer", "Original Publisher",  "Artist", "Distributor", "Remixer", "Other", "Publisher"]
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  

private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end


