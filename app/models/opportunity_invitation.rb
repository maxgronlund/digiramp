class OpportunityInvitation < ActiveRecord::Base
  belongs_to :opportunity
  after_commit :flush_cache
  
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  
end
