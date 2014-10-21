class InstrumentTag < ActiveRecord::Base
  #belongs_to :recording
  belongs_to :instrument
  belongs_to :instrument_tagable, polymorphic: true
  
  after_commit :flush_cache
  after_create :count_instruments_up
  before_destroy :count_instruments_down 
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
private
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  def count_instruments_up
    self.instrument.recordings_count += 1
    self.instrument.save!
  end
  
  def count_instruments_down
    self.instrument.recordings_count -= 1
    self.instrument.save!
  end
  
end
