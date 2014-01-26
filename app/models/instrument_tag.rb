class InstrumentTag < ActiveRecord::Base  
  belongs_to :recording
  belongs_to :instrument
  belongs_to :instrument_tagable, polymorphic: true
end
