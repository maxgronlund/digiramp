# encoding: UTF-8
class Recording < ActiveRecord::Base
  
  serialize :audio_upload, Hash
  
  
  include PgSearch
  pg_search_scope :search, against: [ :title, 
                                      :lyrics, 
                                      :production_company, 
                                      :isrc_code, 
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
  
  #require 'taglib'
  #scope :none, where("1 = 0")
  #scope :none, -> { where(color: "1 = 0") }
  
  belongs_to :account
  belongs_to :common_work
  belongs_to :import_batch
  
  #has_many :catalog_items
  #has_many :catalogs, through: :catalog_items
  
  
  
  #has_many :genre_tags
  #has_many :genres, through: :genre_tags
  has_many :genre_tags, as: :genre_tagable,             dependent: :destroy
  has_many :instrument_tags, as: :instrument_tagable,   dependent: :destroy
  has_many :mood_tags, as: :mood_tagable,               dependent: :destroy
  
  mount_uploader :cover_art, ThumbUploader
  
  VOCAL = [ "Female", "Male", "Female & Male", "Urban", "Rap", "Choir", "Child", "Spoken", "Instrumental" ]
  TEMPO = [ "Fast", "Laid Back", "Steady Rock", "Medium", "Medium-Up", "Ballad", "Brisk", "Up", "Slowly", "Up Beat" ]
  
  def catalogs
    catalog_ids = CatalogItem.where(catalog_itemable_type: self.class.name, catalog_itemable_id: self.id).pluck(:catalog_id)
    Catalog.find(catalog_ids)
  end
  
  
  #belongs_to :song
  #belongs_to :album
  
  #has_many :genre_tags
  #has_many :genres, through: :genre_tags
  #
  #has_many :mood_tags
  #has_many :moods, through: :mood_tags
  #
  #has_many :instrument_tags
  #has_many :instruments, through: :instrument_tags
  #
  #has_many :account_catalogs
  #has_many :catalogs, through: :account_catalogs
  #
  #has_many :documents, as: :documentable, dependent: :destroy
  #has_many :activity_events, as: :activity_eventable
  
  #mount_uploader :poster, PosterUploader
  #include ImageCrop
  
  #mount_uploader :mp4_video, Mp4Uploader
  #mount_uploader :ogv_video, OgvUploader
  #mount_uploader :webm_video, WebmUploader
  
  
  
  #before_create :update_counter_cache
  #scope video,        ->    { where(media_type: 'Video')}
  #scope recording,    ->    { where(media_type: 'Recording')}
    
  #mount_uploader :audio_file, AudioFileUploader
  #process_in_background :audio_file
  
  #before_save :update_audio_file_attributes
  #after_create :check_for_title_and_common_work
  #after_create :try_extract_id3_tags
  #after_create :check_title
  
  #CATEGORY = ["super", "cuctomer"]
  
  #after_commit :expire_account_rec_cash
  after_commit :flush_cache
  before_destroy :remove_from_catalogs
  before_destroy :remove_from_albums
  
  
  #def expire_account_rec_cash
  #  
  #  account.rec_cache_version += 1
  #  account.save!
  #
  #end
  
  
  
  def file
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
  
  def self.account_search(account, query)
    recordings = account.recordings
    if query.present?
     recordings = recordings.search(query)
    end
    recordings
  end
  
  def update_completeness

    self.completeness_in_pct = 0
    
            # 30  
    unless self.isrc_code.empty? 
      self.completeness_in_pct += 5 
    end
    unless self.comment.to_s == ''
      self.completeness_in_pct += 10 
      logger.debug 'has description'
    end             # 50
    if self.vocal != 'Instrumental' && !self.lyrics.to_s == ''
      self.completeness_in_pct += 10 
    else 
      self.completeness_in_pct += 10 
    end

    unless self.genre.to_s == ''
      self.completeness_in_pct += 10 
    end  
    
    #unless self.empty?
    #  self.completeness_in_pct += 10 
    #end 
    
    unless self.artist.to_s == ''
      self.completeness_in_pct += 10 
    end 
    
    unless self.performer.to_s == ''
      self.completeness_in_pct += 10 
    end  
    
    unless self.band.to_s == ''
      self.completeness_in_pct += 5 
    end            # 70

    unless self.duration == 0   
      self.completeness_in_pct += 5 
    end              # 90 
    unless self.bpm == 0           
      self.completeness_in_pct += 5 
    end             # 100
    self.save!(validate: false)
    
    # Album
    # quality of common work
    # artwork

  end
  
  def in_good_condition?
    
    self.completeness_in_pct > 30

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
  
  #def apply_common_work
  #  
  #  
  #  unless common_work
  #    CommonWork.create(account_id: self.account_id, title: self.title, lyrics: self.lyrics)
  #  end
  #    
  #end
  
  def duration_string

      hours   = (self.duration / 3600).to_i
      minutes = (self.duration / 60).to_i - hours
      seconds = self.duration.to_i - (minutes * 60)
      msec    = (self.duration * 100).to_i - (self.duration.to_i * 100)
      timeString = convertToTwoDigitString(hours) + ':' + convertToTwoDigitString(minutes) + ':' + convertToTwoDigitString(seconds) + ':' + convertToTwoDigitString(msec)
      return timeString


  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
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
        recording.save!
        recording.extract_genres
        recording.extract_instruments
        recording.extract_moods

      rescue
      end
    end
  end
  
  
  def extract_genres
    self.genre.split(',').each do |genre|

      extracted_genre = Genre.where(title: genre.strip).first_or_create(title: genre.strip, user_tag: true, category: 'User Genre')

      GenreTag.where( genre_id: extracted_genre.id, 
                      genre_tagable_type: self.class.to_s, 
                      genre_tagable_id: self.id)
                      .first_or_create(
                        genre_id: extracted_genre.id, 
                        genre_tagable_type: self.class.to_s, 
                        genre_tagable_id: self.id
                     )
    end
  end
  
  
  def extract_instruments
    self.instruments.split(',').each do |instrument|

      extracted_instrument = Instrument.where(title: instrument.strip).first_or_create(title: instrument.strip, user_tag: true, category: 'User Instrument')

      InstrumentTag.where( instrument_id: extracted_instrument.id, 
                           instrument_tagable_type: self.class.to_s, 
                           instrument_tagable_id: self.id)
                           .first_or_create(
                             instrument_id: extracted_instrument.id, 
                             instrument_tagable_type: self.class.to_s, 
                             instrument_tagable_id: self.id
                          )
    end
  end
  
  def extract_moods
    self.mood.split(',').each do |mood|

      extracted_mood = Mood.where(title: mood.strip).first_or_create(title: mood.strip, user_tag: true, category: 'User Mood')

      MoodTag.where( mood_id: extracted_mood.id, 
                           mood_tagable_type: self.class.to_s, 
                           mood_tagable_id: self.id)
                           .first_or_create(
                             mood_id: extracted_mood.id, 
                             mood_tagable_type: self.class.to_s, 
                             mood_tagable_id: self.id
                          )
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
    account.rec_cache_version += 1
    account.save!
    Rails.cache.delete([self.class.name, id])
  end
  
  def remove_from_catalogs
    catalog_items = CatalogItem.where(catalog_itemable_id: self.id, catalog_itemable_type: self.class.name)
    catalog_items.delete_all
    
    playlist_items = PlaylistItem.where(playlist_itemable_id: self.id, playlist_itemable_type: self.class.name)
    playlist_items.delete_all
    
  end
  
  def remove_from_albums
    
    
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
  
  
  
  
  
  
  
end
