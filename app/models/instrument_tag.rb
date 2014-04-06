class InstrumentTag < ActiveRecord::Base
  #belongs_to :recording
  belongs_to :instrument
  belongs_to :instrument_tagable, polymorphic: true
  
  after_commit :flush_cache
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
private
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
