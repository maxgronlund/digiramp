class IpiCode < ActiveRecord::Base
  
  belongs_to :account
  belongs_to :ipiable, polymorphic: true
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
end
