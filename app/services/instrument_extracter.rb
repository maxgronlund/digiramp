

class InstrumentExtracter

  def self.process recording
    
    # store old  tag id's so we can delete unused
    instrument_tag_ids      = recording.instrument_tags.pluck(:id)
    new_instrument_tag_ids  = []
    
    # read comma seperated list
    recording.instruments.split(',').each do |instrument|

      # find or create genre
      extracted_instrument = Instrument.where(title: instrument.strip)
                                        .first_or_create(
                                              title: instrument.strip, 
                                              user_tag: true, 
                                              category: 'User Instrument')
      
      # find or create instrument tag
      instrument_tag = InstrumentTag.where(  instrument_id: extracted_instrument.id, 
                                             instrument_tagable_type: recording.class.to_s, 
                                             instrument_tagable_id: recording.id)
                                             .first_or_create(
                                               instrument_id: extracted_instrument.id, 
                                               instrument_tagable_type: recording.class.to_s, 
                                               instrument_tagable_id: recording.id
                                            )
      # store used tag ids
      new_instrument_tag_ids << instrument_tag.id
    end
    # remove not used tags
    if instrument_tags = InstrumentTag.where(id: (instrument_tag_ids - new_instrument_tag_ids))
      instrument_tags.destroy_all
    end
    
    
    
  end

end