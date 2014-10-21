class FixRecordingCountOnTags < ActiveRecord::Migration
  def change
    # clean up Moods
    Mood.find_each do |mood|
      mood.mood_tags.find_each do |mood_tag|
        case mood_tag.mood_tagable_type
        when 'Recording'
          unless Recording.exists?(mood_tag.mood_tagable_id)
            mood_tag.destroy
          end
        end
      end
      mood.reset_count
    end
    
    # clean up Instruments
    Instrument.find_each do |instrument|
      instrument.instrument_tags.find_each do |instrument_tag|
        case instrument_tag.instrument_tagable_type
        when 'Recording'
          unless Recording.exists?(instrument_tag.instrument_tagable_id)
            instrument_tag.destroy
          end
        end
      end
      instrument.reset_count
    end
  end
end
