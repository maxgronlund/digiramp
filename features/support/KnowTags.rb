module KnowTagsHelper

  def find_or_create_genre_tag  title
    return @genre_tag if @genre_tag = genre_tag_with_title( title )
    @genre_tag = FactoryGirl.create(:genre, title: title)
  end
  
  def genre_tag_with_title title
    Genre.find_by(title: title)
  end
  


  def find_or_create_mood_tag  title
    return @genre_tag if @genre_tag = genre_tag_with_title( title )
    @genre_tag = FactoryGirl.create(:mood, title: title)
  end
  
  def mood_tag_with_title title
    Mood.find_by(title: title)
  end
  


  def find_or_create_instrument_tag  title
    return @genre_tag if @genre_tag = instrument_tag_with_title( title )
    @genre_tag = FactoryGirl.create(:instrument, title: title)
  end
  
  def instrument_tag_with_title title
    Instrument.find_by(title: title)
  end

  
end

World(KnowTagsHelper)