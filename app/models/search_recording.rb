class SearchRecording < ActiveRecord::Base
  belongs_to :user
  serialize :genres
  serialize :moods
  serialize :instruments
  
  BASE_DATE = Time.parse("2000-01-01 00:00:00 UTC")

  SEARCH_IN = ["Catalog", "Account", "Imports", "Latest import"]
  
  def recordings
    #@recordings ||= find_recordings
  end
  
private 

  def find_recordings    
    #advanced_search ? advanced_search_result : simple_search_result
  end
  
  def simple_search_result
    #recordings_search = RecordingsSearch.new(user_id, account_id)
    #recordings_search.text simple_search_query unless simple_search_query.to_s.contains_nothing?
    #recordings_search.result
  end
  
  def advanced_search_result
    #recordings_search = RecordingsSearch.new(user_id, account_id)
    #recordings_search.explicit     false if exclude_explicit
    #recordings_search.instrumental false if exclude_instrumental
    #recordings_search.clearance    true  if full_clearance
    #recordings_search.genres      genres      unless genres.to_a.empty? if has_genres
    #recordings_search.moods       moods       unless moods.to_a.empty? if has_moods
    #recordings_search.instruments instruments unless instruments.to_a.empty? if has_instruments
    #recordings_search.bpm(min_bpm..max_bpm) if min_bpm && max_bpm if has_bpm
    #
    #text_query = title_lyrics_description_query.to_s
    #
    #if has_duration
    #  begin
    #    if self.min_duration && self.max_duration
    #      ## Seems the UTC and BASE_DATE IS needed
    #      min_duration = Time.parse "#{self.min_duration} UTC", BASE_DATE
    #      max_duration = Time.parse "#{self.max_duration} UTC", BASE_DATE
    #      recordings_search.duration(min_duration..max_duration)
    #    end
    #  rescue ArgumentError
    #  end
    #end
    #
    #unless text_query.contains_nothing?
    #  recordings_search.title_text        text_query if title
    #  recordings_search.description_text  text_query if description
    #  recordings_search.lyrics_text       text_query if lyrics
    #end
    #
    #recordings_search.result
  end
end
