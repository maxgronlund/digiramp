# MoodExtracter.process

class MoodExtracter

  def self.process recording
    
    mood_tag_ids      = recording.mood_tags.pluck(:id)
    new_mood_tag_ids  = []
    
    # read comma seperated list
    recording.mood.split(',').each do |mood|
      
      # find or create mood
      extracted_mood = Mood.where(title: mood.strip)
                            .first_or_create( title: mood.strip, 
                                              user_tag: true, 
                                              category: 'User Mood'
                                            )
      # find or create mood tag
      mood_tag = MoodTag.where( mood_id: extracted_mood.id, 
                           mood_tagable_type: recording.class.to_s, 
                           mood_tagable_id: recording.id)
                           .first_or_create(
                             mood_id: extracted_mood.id, 
                             mood_tagable_type: recording.class.to_s, 
                             mood_tagable_id: recording.id
                          )
      new_mood_tag_ids << mood_tag.id
    end
    
    # remove not used tags
    if mood_tags = MoodTag.where(id: (mood_tag_ids - new_mood_tag_ids))
      mood_tags.destroy_all
    end
  end

end