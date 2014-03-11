class Recording < ActiveRecord::Base
  
  serialize :audio_upload, Hash
  include PgSearch
  pg_search_scope :search, against: [:title, :artists, :lyrics, :production_company, :isrc_code ], :using => [:tsearch]
  
  
  #require 'taglib'
  #scope :none, where("1 = 0")
  scope :none, -> { where(color: "1 = 0") }
  
  belongs_to :account
  belongs_to :common_work
  belongs_to :song
  belongs_to :album
  
  has_many :genre_tags
  has_many :genres, through: :genre_tags
  
  has_many :mood_tags
  has_many :moods, through: :mood_tags
  
  has_many :instrument_tags
  has_many :instruments, through: :instrument_tags
  
  has_many :account_catalogs
  has_many :catalogs, through: :account_catalogs
  
  has_many :documents, as: :documentable, dependent: :destroy
  has_many :activity_events, as: :activity_eventable
  
  #mount_uploader :poster, PosterUploader
  #include ImageCrop
  
  #mount_uploader :mp4_video, Mp4Uploader
  #mount_uploader :ogv_video, OgvUploader
  #mount_uploader :webm_video, WebmUploader
  
  #validates :title, :presence => true
  
  #before_create :update_counter_cache
  #scope video,        ->    { where(media_type: 'Video')}
  #scope recording,    ->    { where(media_type: 'Recording')}
    
  #mount_uploader :audio_file, AudioFileUploader
  #process_in_background :audio_file
  
  #before_save :update_audio_file_attributes
  #after_create :check_for_title_and_common_work
  #after_create :try_extract_id3_tags
  #after_create :check_title
  
  CATEGORY = ["super", "cuctomer"]
  
  after_commit :expire_account_rec_cash
  
  
  def expire_account_rec_cash
    
    account.rec_cache_version += 1
    account.save!

  end
  
  def file
  end
  
  def catalog_ids=(ids) 
    
    ids.each do |catalog_id|
      index = catalog_id.to_i
      if index != 0
        catalog = AccountCatalog.find(index)
        logger.debug catalog.title
        CatalogItem.create( catalog_itemable_id: id, account_catalog_id: catalog.id, catalog_itemable_type: 'Recording' )
      end
    end

  end
  
  def duration_text
    duration.try(:strftime, "%H:%M:%S")
  end
  
  def duration_text=(duration)
    self.duration = Time.zone.parse(duration) if duration.present?
  end
  
  def docs
    Document.where(documentable_id: self.id, documentable_type: 'Recording')
  end
  
  
  def extract_id3_tags_from_audio_file
    
    path = self.audio_upload[:uploads][0][:url]
    
    #id3_tags = Id3Tags.read_tags_from self.audio_file.current_path
    id3_tags = Id3Tags.read_tags_from path

    if id3_tags[:cover_art]
      cover_art_store_path = Rails.root.join("public", "uploads", "tmp", "id3covers")
  
      cover_art_path = case id3_tags[:cover_art][:mime_type]
      when "image/png";               File.join(cover_art_store_path, "cover#{Time.now.to_f}-#{rand}.png")
      when "image/jpeg", "image/jpg"; File.join(cover_art_store_path, "cover#{Time.now.to_f}-#{rand}.jpg")
      when "image/tiff";              File.join(cover_art_store_path, "cover#{Time.now.to_f}-#{rand}.tiff")
      when "image/gif";               File.join(cover_art_store_path, "cover#{Time.now.to_f}-#{rand}.gif")
      when "image/bmp", "image/x-windows-bmp"
        File.join(cover_art_store_path, "cover#{Time.now.to_f}-#{rand}.bmp")
      end
  
      if cover_art_path && id3_tags[:cover_art][:data]
        Dir.mkdir Rails.root.join("public", "uploads", "tmp") rescue Errno::EEXIST
        Dir.mkdir cover_art_store_path                        rescue Errno::EEXIST
        File.open(cover_art_path, 'wb') {|f| f.write id3_tags[:cover_art][:data] }
        self.poster = File.open(cover_art_path)
      end
    end

    lyrics       = id3_tags[:lyrics].to_s
    title        = id3_tags[:title].to_s
    artist       = id3_tags[:artist].to_s
    album_artist = id3_tags[:album_artist].to_s
    album        = id3_tags[:album].to_s
    grouping     = id3_tags[:grouping].to_s
    composer     = id3_tags[:composer].to_s
    comment      = id3_tags[:comment].to_s
    genre        = id3_tags[:genre].to_s
    compilation  = id3_tags[:compilation].to_s
    year         = id3_tags[:year].to_i
    track_number = id3_tags[:track][:number]
    track_count  = id3_tags[:track][:count]
    disk_number  = id3_tags[:disk][:number]
    disk_count   = id3_tags[:disk][:count]
    bpm          = id3_tags[:bpm]
    length       = id3_tags[:length].to_i
    bitrate      = id3_tags[:bitrate].to_i
    samplerate   = id3_tags[:samplerate].to_i
    channels     = id3_tags[:channels].to_i
    
    #title       = ""
    #artists     = ""
    #album       = ""
    #year        = ""
    #track       = ""
    #genre       = ""
    #comment     = ""
    #song_length = 0
    #TagLib::FileRef.open(audio_file.current_path) do |fileref|
    #  if fileref.null?
    #    puts '-------------------   no fileref ------------------------------'
    #  end
    #  unless fileref.null?
    #    tag = fileref.tag
    #    title     = tag.title
    #    artists   = tag.artist  
    #    album     = tag.album   
    #    year      = tag.year    
    #    track     = tag.track   
    #    genre     = tag.genre   
    #    comment   = tag.comment
    #    
    #    ## Clean up the title if the title starts with the track number
    #    ## If the title is in the format number followed by underscore       
    #    if match = title.to_s.match(/^\d+\_/)
    #      track = match.to_s.match(/^\d+/).to_s.to_i if track != 0
    #      title.gsub!(/^\d+\_/, '')
    #      title.gsub!('_', ' ')
    #      title.gsub!(/\s+/, ' ')
    #    end
    #
    #    properties = fileref.audio_properties
    #    song_length = properties.length  #=> 335 (song length in seconds)
    #    channels = properties.channels #=> fixnum
    #    bitrate = properties.bitrate
    #    sample_rate = properties.sample_rate
    #    original = properties.original?
    #  end
    #end  # File is automatically closed at block end
    
    self.lyrics       = lyrics       unless  lyrics           .contains_nothing?
    self.album_artist = album_artist unless  album_artist     .contains_nothing?
    self.album_title  = album        unless  album            .contains_nothing?
    self.grouping     = grouping     unless  grouping         .contains_nothing?
    self.composer     = composer     unless  composer         .contains_nothing?
    self.comment      = comment      unless  comment          .contains_nothing?
    self.compilation  = compilation  unless  compilation      .contains_nothing?
    self.year         = year         unless  year == 0
    
    self.title        = title   unless title.contains_nothing?    
    self.artists      = artist  unless artist.contains_nothing?
    self.track_number = track_number.to_i if track_number
    self.track_count  = track_count.to_i  if track_count
    self.disk_number  = disk_number.to_i if disk_number
    self.disk_count   = disk_count .to_i if disk_count 
    self.duration     = Time.at(length).utc if length != 0
    self.bpm          = bpm if bpm
    
    self.bitrate    = bitrate    unless bitrate    == 0
    self.samplerate = samplerate unless samplerate == 0
    self.channels   = channels   unless channels   == 0
    
    unless genre.contains_nothing?
      genre = Genre.where(title: genre).first_or_create(title: genre, user_tag: true)
      GenreTag.where(recording_id: self.id, genre_id: genre.id).first_or_create(recording_id: self.id, genre_id: genre.id)
    end

    self.save!

  end
  
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

    
    self.completeness_in_pct = 20
    
    if self.has_title     
      self.completeness_in_pct += 10 
    end             # 30  
    if self.isrc_code     
      self.completeness_in_pct += 5 end              # 35
    if self.description   
      self.completeness_in_pct += 15 
    end             # 50
    if self.has_lyrics && self.lyrics 
      self.completeness_in_pct += 10 
    end # 60
    if self.artists       
      self.completeness_in_pct += 10 end             # 70
    if self.instrumental  
      self.completeness_in_pct += 5 
    end              # 75
    if self.explicit      
      self.completeness_in_pct += 5 
    end              # 80   
    if self.release_date  
      self.completeness_in_pct += 5 
    end              # 85
    if self.duration      
      self.completeness_in_pct += 5 
    end              # 90 
    if self.bpm           
      self.completeness_in_pct += 10 
    end             # 100
    self.save!
    
    # Album
    # quality of common work
    # artwork

  end
  
private
  #def update_counter_cache
  #  self.content_type = document.file.content_type
  #end
  
  def update_audio_file_attributes
    if audio_file.present? && audio_file_changed?
      self.content_type     = audio_file.file.content_type
      self.file_size        = audio_file.size

    end
  end
  
  
  def try_extract_id3_tags
    if extract_id3_tags && audio_file.present?
      extract_id3_tags_from_audio_file
    end
  end
  
  def check_title
    if title.to_s == '' && audio_file.present?
      str =  File.basename(audio_file_url).gsub(/[_]/, ' ')  
      self.title = str.gsub(/[.mp3]/, '')
      self.save
    end
  end
  
  
  
  
  
end
