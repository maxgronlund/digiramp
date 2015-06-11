# GenreExtracter.process

class GenreExtracter

  def self.process recording
    
    # store old  tag id's so we can delete unused
    genre_tag_ids = recording.genre_tags.pluck(:id)
    new_genre_tag_ids = []

    
    # go true the list of comma seperated tags
    self.genre.split(',').each do |genre|
      
      # find or create the genre
      extracted_genre = Genre.where(title: genre.strip)
                              .first_or_create(title: genre.strip, 
                                                user_tag: true, 
                                                category: 'User Genre'
                                              )
                                              
      # check if the genre tag alreaddy is there
      genre_tag = GenreTag.where( genre_id: extracted_genre.id, 
                                  genre_tagable_type: recording.class.to_s, 
                                  genre_tagable_id: recording.id)
                                  .first_or_create(
                                    genre_id: extracted_genre.id, 
                                    genre_tagable_type: recording.class.to_s, 
                                    genre_tagable_id: recording.id
                                 )
      # store new tag id
      new_genre_tag_ids << genre_tag.id
    end
    
    # remove not used genre tags
    if genre_tags = GenreTag.where(id: (genre_tag_ids - new_genre_tag_ids))
      genre_tags.destroy_all
    end
  end

end