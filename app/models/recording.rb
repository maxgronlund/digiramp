# encoding: UTF-8
class Recording < ActiveRecord::Base
  include PublicActivity::Common
  # virtual parameter for CommonWorksController#new_recording form
  attr_accessor :add_to_catalogs
  
  
  
  serialize :audio_upload, Hash
  

  include PgSearch
  pg_search_scope :search, against: [ :title, 
                                      :lyrics, 
                                      :genre, 
                                      :artist, 
                                      :bpm, 
                                      :comment, 
                                      :vocal, 
                                      :isrc_code,
                                      :copyright,
                                      :production_company,
                                      :upc_code,
                                      :year,
                                      :album_name,
                                      :performer,
                                      :band,
                                      :mood,
                                      :instruments,
                                      :tempo 
                                    ], :using => [:tsearch]
  
  
  validates :title, :presence => true
  
  scope :bucket,            ->  { where( in_bucket: true)  }
  scope :not_in_bucket,     ->  { where.not( in_bucket: true)  }
  
  belongs_to :account
  belongs_to :common_work
  belongs_to :import_batch
  
  has_many :comments,        as: :commentable,          dependent: :destroy
  has_many :genre_tags,      as: :genre_tagable,        dependent: :destroy
  has_many :instrument_tags, as: :instrument_tagable,   dependent: :destroy
  has_many :mood_tags,       as: :mood_tagable,         dependent: :destroy
  has_many :image_files,                                dependent: :destroy
  has_many :recording_items,                            dependent: :destroy
  has_many :recording_ipis,                             dependent: :destroy
  
  before_save :update_uuids
  after_commit :flush_cache
  before_destroy :remove_from_collections
  after_create :count_stats_up
  

  
  VOCAL = [ "Female", "Male", "Female & Male", "Urban", "Rap", "Choir", "Child", "Spoken", "Instrumental" ]
  TEMPO = [ "Fast", "Laid Back", "Steady Rock", "Medium", "Medium-Up", "Ballad", "Brisk", "Up", "Slowly", "Up Beat" ]
  
  VOCAL_HASH = []
  
  VOCAL.each do |k|
    VOCAL_HASH << [k,k]
  end
  
  
  
 
  def catalogs
    catalog_ids = CatalogItem.where(catalog_itemable_type: "Recording", catalog_itemable_id: self.id).pluck(:catalog_id)
    cats = Catalog.find(catalog_ids)
    cats
  end

  
  def catalog_ids=(ids) 
    
    ids.each do |catalog_id|
      index = catalog_id.to_i
      if index != 0
        catalog = AccountCatalog.find(index)
        #logger.debug catalog.title
        CatalogItem.create( catalog_itemable_id: id, account_catalog_id: catalog.id, catalog_itemable_type: 'Recording' )
      end
    end

  end
  
  #def duration_text
  #  duration.try(:strftime, "%H:%M:%S")
  #end
  #
  #def duration_text=(duration)
  #  self.duration = Time.zone.parse(duration) if duration.present?
  #end
  
  def docs
    Document.where(documentable_id: self.id, documentable_type: 'Recording')
  end
  
  def artworks
    artwork_ids = RecordingItem.where(recording_id: self.id, 
                                      itemable_type: 'Artwork').pluck(:itemable_id)
                                      
    Artwork.where(id: artwork_ids )
    
  end
  
  
  #def extract_id3_tags_from_audio_file
  # 
  #
  #end
  
  #def check_common_work
  #  if common_work_id.nil?
  #    common_work           = account.common_works.create(title: title, account_id: account_id, audio_file: audio_file)
  #    self.common_work_id   = common_work.id 
  #    self.save
  #  end
  #end
  
  def self.find_in_collection(catalog, account, query)
    
    recording_ids = account.recording_ids - catalog.recording_ids
    recordings    = Recording.where(id: recording_ids)

    if query.present?
     recordings = recordings.search(query)
    end
    recordings
  end
  
  def self.account_bucket_search(account, query)
    recordings = account.recordings.bucket
    if query.present?
     recordings = recordings.search(query)
    end
    recordings
  end
  
  def self.search_all(query)
    
    if query.present?
     recordings = Recording.search(query)
    else
      Recording.all
    end
    
  end
  
  def self.search_from_ids(recording_ids, query)
    recordings = Recording.where(id: recording_ids)
    if query.present?
     recordings = recordings.search(query)
    end
    recordings
  end
  
  def self.account_search(account, query)
    recordings = account.recordings.not_in_bucket
    if query.present?
     recordings = recordings.search(query)
    end
    recordings
  end
  
  def self.catalogs_search(recordings, query)
    if query.present?
     recordings = recordings.search(query)
    end
    recordings
  end
  
  
  # remove disk_number, disk_count, track_count, available_date
  def update_completeness

    self.completeness_in_pct = 0
    
    
    self.completeness_in_pct += 4 unless self.isrc_code.to_s             == ''                 
    self.completeness_in_pct += 4 unless self.artist.to_s                == ''                    
    self.completeness_in_pct += 4 unless self.lyrics.to_s                == ''                    
    self.completeness_in_pct += 4 unless self.bpm.to_s                   == '0'                       
    self.completeness_in_pct += 4 unless self.comment.to_s               == ''                                      
    self.completeness_in_pct += 4 unless self.copyright.to_s             == ''              
    self.completeness_in_pct += 4 unless self.production_company.to_s    == ''         
    self.completeness_in_pct += 4 unless self.album_artist.to_s          == ''     
    self.completeness_in_pct += 4 unless self.album_title.to_s           == ''     
    self.completeness_in_pct += 4 unless self.grouping.to_s              == ''     
    self.completeness_in_pct += 4 unless self.composer.to_s              == ''     
    #self.completeness_in_pct += 4 unless self.compilation.to_s           == ''     
    self.completeness_in_pct += 4 unless self.year.to_s                  == ''                   
    self.completeness_in_pct += 4 unless self.duration.to_s              == ''               
    self.completeness_in_pct += 4 unless self.album_name.to_s            == ''             
    self.completeness_in_pct += 4 unless self.genre.to_s                 == ''                  
    self.completeness_in_pct += 4 unless self.performer.to_s             == ''              
    self.completeness_in_pct += 4 unless self.band.to_s                  == ''                   
    self.completeness_in_pct += 4 unless self.disc.to_s                  == ''                   
    self.completeness_in_pct += 4 unless self.track.to_s                 == ''                  
    self.completeness_in_pct += 4 unless self.cover_art.to_s             == ''     
    self.completeness_in_pct += 5 unless self.vocal.to_s                 == ''                  
    self.completeness_in_pct += 5 unless self.mood.to_s                  == ''                   
    self.completeness_in_pct += 5 unless self.instruments.to_s           == ''            
    self.completeness_in_pct += 5 unless self.tempo.to_s                 == '' 
    
    self.cache_version += 1
    
    self.save!(validate: false)
    
    

  end
  
  def in_good_condition?
    
    self.completeness_in_pct > 30

  end
  
  def build_permissions
    
    
    
  end
  
  def extract_metadata
    
    begin
      meta              = audio_upload[:uploads].first[:meta]

      self.title        = TransloaditParser.sanitize_title( meta[:title].to_s )    
      self.duration     = meta[:duration].to_f.round(2)   
      self.lyrics        = TransloaditParser.sanitize_lyrics( meta[:lyrics].to_s )        
      #self.lyrics       = meta[:lyrics].gsub(/\//, '<br>')      
      self.bpm          = meta[:beats_per_minute].to_i          
      self.album_name   = meta[:album].to_s                     
      self.year         = meta[:year].to_s                           
      self.genre        = meta[:genre].to_s                           
      self.artist       = meta[:artist].to_s                          
      self.comment      = TransloaditParser.sanitize_comment( meta[:comment].to_s )     
      self.performer    = meta[:performer].to_s                                  
      self.band         = meta[:band].to_s                            
      self.disc         = meta[:disc].to_s                            
      self.track        = meta[:track].to_s    
      #copyright:         transloaded[:copyright],
      #composer:          transloaded[:composer],                       
      self.save!            

    rescue
      
    end
 
    
  
  end

  
  def duration_string
    hours   = (self.duration / 3600).to_i
    minutes = (self.duration / 60).to_i - hours
    seconds = self.duration.to_i - (minutes * 60)
    msec    = (self.duration * 100).to_i - (self.duration.to_i * 100)
    timeString = convertToTwoDigitString(minutes) + ':' + convertToTwoDigitString(seconds) + ':' + convertToTwoDigitString(msec)
    return timeString
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { where(id: id).first }
  end
  
  
  def self.to_csv
    CSV.generate do |csv|

      #csv << column_names
      csv << ['Account Id',
              'Recording Id', 
              'Work ID', 
              'Title', 
              'ISRC Code', 
              'Artist', 
              'Performer', 
              'Band', 
              'Year', 
              'Album Name',
              'Vocal',
              'Genre', 
              'Mood', 
              'Instruments', 
              'Disc', 
              'Track', 
              'BPM', 
              'Tempo',
              #'Comment',
              'Explicit', 
              'Clearance', 
              'Copyright', 
              'Production Company',
              'Composer'  
            ]
      
      all.each do |recording|
        
        #genre = ''
        #recording.genre_tags.each do |genre_tag|
        #  genre << genre_tag.genre.title
        #  genre << ','
        #end
        
        

        csv << [  recording.account_id, 
                  recording.id, 
                  recording.common_work_id,
                  recording.title,
                  recording.isrc_code,
                  recording.artist.to_s.squish,
                  recording.performer.to_s.squish,
                  recording.band.to_s.squish,
                  recording.year,
                  recording.album_name.to_s.squish,
                  recording.vocal,
                  recording.genre_tags_as_csv_string,
                  recording.moods_tags_as_csv_string,
                  recording.instruments_tags_as_csv_string,
                  recording.disc,
                  recording.track,
                  recording.bpm,
                  recording.tempo,
                  #recording.comment.to_s.squish,
                  recording.explicit,
                  recording.clearance,
                  recording.copyright.to_s.squish,
                  recording.production_company,
                  recording.composer
                
                ]
      end

    end
  end
  
  def self.import_csv(csv_file)
    CSV.foreach(csv_file.path, headers: true) do |row|
      recording_row = row.to_hash
      begin
        #recording = Recording.find(recording_row["Recording Id"].to_id)
        recording = Recording.cached_find(recording_row["Recording Id"].to_i)
        # make check for permissions here
        recording.account_id            = recording_row["Account Id"].to_i                unless recording_row["Account Id"].to_s.empty?
        recording.common_work_id        = recording_row["Work ID"].to_i                   unless recording_row["Work ID"].to_s.empty?
        recording.title                 = recording_row["Title"].to_s                     unless recording_row["Title"].to_s.empty?
        recording.isrc_code             = recording_row["ISRC Code"].to_s                 unless recording_row["ISRC Code"].to_s.empty?
        recording.artist                = recording_row["Artist"].to_s                    unless recording_row["Artist"].to_s.empty?
        recording.performer             = recording_row["Performer"].to_s                 unless recording_row["Performer"].to_s.empty?
        recording.band                  = recording_row["Band"].to_s                      unless recording_row["Band"].to_s.empty?
        recording.year                  = recording_row["Year"].to_s                      unless recording_row["Year"].to_s.empty?
        recording.album_name            = recording_row["Album Name"].to_s                unless recording_row["Album Name"].to_s.empty?
        recording.vocal                 = recording_row["Vocal"].to_s                     unless recording_row["Vocal"].to_s.empty?
        recording.genre                 = recording_row["Genre"].to_s                     unless recording_row["Genre"].to_s.empty?
        recording.mood                  = recording_row["Mood"].to_s                      unless recording_row["Mood"].to_s.empty?
        recording.instruments           = recording_row["Instruments"].to_s               unless recording_row["Instruments"].to_s.empty?
        recording.disc                  = recording_row["Disc"].to_s                      unless recording_row["Disc"].to_s.empty?
        recording.track                 = recording_row["Track"].to_s                     unless recording_row["Track"].to_s.empty?
        recording.bpm                   = recording_row["BPM"].to_i                       unless recording_row["BPM"].to_s.empty?
        recording.explicit              = recording_row["Explicit"].to_s       == 'true'  unless recording_row["Explicit"].to_s.empty?
        recording.clearance             = recording_row["Clearance"].to_s      == 'true'  unless recording_row["Clearance"].to_s.empty?
        recording.copyright             = recording_row["Copyright"].to_s                 unless recording_row["Copyright"].to_s.empty?
        recording.production_company    = recording_row["Production Company"].to_s        unless recording_row["Production Company"].to_s.empty?
        recording.composer              = recording_row["Composer"].to_s                  unless recording_row["Composer"].to_s.empty?

        recording.cache_version += 1
        recording.save
        recording.extract_genres
        recording.extract_instruments
        recording.extract_moods
        recording.common_work.update_completeness

      rescue
      end
    end
  end
  
  # update the genre
  def extract_genres

    # store old  tag id's so we can delete unused
    genre_tag_ids = self.genre_tags.pluck(:id)
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
                                  genre_tagable_type: self.class.to_s, 
                                  genre_tagable_id: self.id)
                                  .first_or_create(
                                    genre_id: extracted_genre.id, 
                                    genre_tagable_type: self.class.to_s, 
                                    genre_tagable_id: self.id
                                 )
      # store new tag id
      new_genre_tag_ids << genre_tag.id
    end
    
    # remove not used genre tags
    if genre_tags = GenreTag.where(id: (genre_tag_ids - new_genre_tag_ids))
      genre_tags.destroy_all
    end
  end
  
  
  # update instruments
  def extract_instruments
    # store old  tag id's so we can delete unused
    instrument_tag_ids      = self.instrument_tags.pluck(:id)
    new_instrument_tag_ids  = []
    
    # read comma seperated list
    self.instruments.split(',').each do |instrument|

      # find or create genre
      extracted_instrument = Instrument.where(title: instrument.strip)
                                        .first_or_create(
                                              title: instrument.strip, 
                                              user_tag: true, 
                                              category: 'User Instrument')
      
      # find or create instrument tag
      instrument_tag = InstrumentTag.where(  instrument_id: extracted_instrument.id, 
                                             instrument_tagable_type: self.class.to_s, 
                                             instrument_tagable_id: self.id)
                                             .first_or_create(
                                               instrument_id: extracted_instrument.id, 
                                               instrument_tagable_type: self.class.to_s, 
                                               instrument_tagable_id: self.id
                                            )
      # store used tag ids
      new_instrument_tag_ids << instrument_tag.id
    end
    # remove not used tags
    if instrument_tags = InstrumentTag.where(id: (instrument_tag_ids - new_instrument_tag_ids))
      instrument_tags.destroy_all
    end
  end
  
  def extract_moods
    # store old  tag id's so we can delete unused
    mood_tag_ids      = self.mood_tags.pluck(:id)
    new_mood_tag_ids  = []
    
    # read comma seperated list
    self.mood.split(',').each do |mood|
      
      # find or create mood
      extracted_mood = Mood.where(title: mood.strip)
                            .first_or_create( title: mood.strip, 
                                              user_tag: true, 
                                              category: 'User Mood'
                                            )
      # find or create mood tag
      mood_tag = MoodTag.where( mood_id: extracted_mood.id, 
                           mood_tagable_type: self.class.to_s, 
                           mood_tagable_id: self.id)
                           .first_or_create(
                             mood_id: extracted_mood.id, 
                             mood_tagable_type: self.class.to_s, 
                             mood_tagable_id: self.id
                          )
      new_mood_tag_ids << mood_tag.id
    end
    
    # remove not used tags
    if mood_tags = MoodTag.where(id: (mood_tag_ids - new_mood_tag_ids))
      mood_tags.destroy_all
    end
  end
  
  
  
  def genre_tags_as_csv_string
    comma_seperated_genre_tags = ''
    genre_tags.each do |genre_tag|
      comma_seperated_genre_tags += genre_tag.genre.title
      comma_seperated_genre_tags += ', '
    end
    # remove last ','
    comma_seperated_genre_tags.rstrip.gsub(/\W\z/, '') 

  end
  
  
  def instruments_tags_as_csv_string
    comma_seperated_instruments_tags = ''
    instrument_tags.each do |instrument_tag|
      begin
        comma_seperated_instruments_tags += instrument_tag.instrument.title
        comma_seperated_instruments_tags += ', '
      rescue
        instrument_tag.destroy
      end
    end
    comma_seperated_instruments_tags.rstrip.gsub(/\W\z/, '') 
  end
  
  def moods_tags_as_csv_string
    comma_seperated_moods_tags = ''
    mood_tags.each do |mood_tag|
      begin
        comma_seperated_moods_tags += mood_tag.mood.title
        comma_seperated_moods_tags += ', '
      rescue
        mood_tag.destroy
      end
    end
    comma_seperated_moods_tags.rstrip.gsub(/\W\z/, '') 
  end
  
  
  # add this to environment variables
  # read from yaml file
  def download_url(style = nil, expires_in = 90.minutes)
    begin
      AWS.config(access_key_id: ENV["S3_KEY_ID"],  secret_access_key: ENV["S3_ACCESS_KEY"] ) 
      s3 = AWS::S3.new
      bucket = s3.buckets['digiramp'] # makes no request
      bucket.objects[self.mp3.gsub('http://digiramp.s3.amazonaws.com/', '')].url_for(:read, :secure => true, :expires => 10*60).to_s
    rescue
    end
  end

private
  #def update_counter_cache
  #  self.content_type = document.file.content_type
  #end
  
  def convertToTwoDigitString inInt
    if inInt < 10 
      return "0" + inInt.to_s;
    end
    inInt.to_s
  end
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  def count_stats_up
    #Statistics.first.recordings += 1
    #Statistics.first.save!
    
    ## optimization
    #catalogs.each do |catalog|
    #  catalog.nr_recordings += 1
    #  catalog.save!
    #end
  end
  
  def count_stats_down
    #puts '---------------------------------------------------------------'
    #puts 'count_stats_down'
    #puts catalogs.size
    #puts '---------------------------------------------------------------'
    #Statistics.first.recordings -= 1
    #Statistics.first.save!
    
    #ap CatalogItem.where(catalog_itemable_id: self.id)
    
    # optimization
    #catalogs.each do |catalog|
    #  catalog.nr_recordings -= 1
    #  catalog.save!
    #  ap catalog
    #*end*
  end
  
  
  
  def remove_from_collections
    update_uuids
    remove_from_catalogs
    remove_from_albums
    count_stats_down
    remove_from_submissions
  end
  
  def remove_from_catalogs
    catalog_items = CatalogItem.where(catalog_itemable_id: self.id, catalog_itemable_type: self.class.name)
    catalog_items.destroy_all
    
    playlist_items = PlaylistItem.where(playlist_itemable_id: self.id, playlist_itemable_type: self.class.name)
    playlist_items.destroy_all
    
  end
  
  def remove_from_albums

  end
  
  def remove_from_submissions
    if music_submissions = MusicSubmission.where(recording_id: self.id)
      music_submissions.destroy_all
    end
  end
  
  def update_audio_file_attributes
    if audio_file.present? && audio_file_changed?
      self.content_type     = audio_file.file.content_type
      self.file_size        = audio_file.size

    end
  end
  
  
  #def try_extract_id3_tags
  #  if extract_id3_tags && audio_file.present?
  #    extract_id3_tags_from_audio_file
  #  end
  #end
  
  def check_title
    if title.to_s == '' && audio_file.present?
      str =  File.basename(audio_file_url).gsub(/[_]/, ' ')  
      self.title = str.gsub(/[.mp3]/, '')
      self.save
    end
  end
  
  def update_uuids
    #AccountCache.update_works_uuid self.account
    AccountCache.update_recordings_uuid(self.account) if self.account_id
    self.uuid = UUIDTools::UUID.timestamp_create().to_s
  end
  
  
  
  
  
end
