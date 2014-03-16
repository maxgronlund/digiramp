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
  
  #CATEGORY = ["super", "cuctomer"]
  
  #after_commit :expire_account_rec_cash
  after_commit :flush_cache
  
  
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
  
  def extract_metadata
    
    return if audio_upload == ''
    return if audio_upload[:uploads].nil?
    return if audio_upload[:uploads][0].nil?
    return if audio_upload[:uploads][0][:meta].nil?
    meta        = audio_upload[:uploads][0][:meta]
    

    self.duration     = meta[:duration].to_f.round(2)     unless meta[:duration].nil?  
    self.lyrics       = meta[:lyrics].gsub(/\//, '<br>')  unless meta[:lyrics].nil? 
    self.bpm          = meta[:beats_per_minute].to_i      unless meta[:beats_per_minute].nil?
    self.album_name   = meta[:album].to_s                 unless meta[:album].nil?           
    self.year         = meta[:year]                       unless meta[:year].nil?            
    self.genre        = meta[:genre]                      unless meta[:genre].nil?           
    self.artist       = meta[:artist]                     unless meta[:artist].nil?          
    self.comment      = meta[:comment]                    unless meta[:comment].nil?         
    self.performer    = meta[:performer]                  unless meta[:performer].nil?       
    self.title        = meta[:title]                      unless meta[:title].nil?           
    self.band         = meta[:band]                       unless meta[:band].nil?            
    self.disc         = meta[:disc]                       unless meta[:disc].nil?            
    self.track        = meta[:track]                      unless meta[:track].nil?    
    
    
    
    
    
    # dont override metadata extracted
    #temp_duration         = meta[:duration].to_f.round(2)     unless meta[:duration].nil?  
    #temp_lyrics           = meta[:lyrics].gsub(/\//, '<br>')  unless meta[:lyrics].nil? 
    #temp_bpm              = meta[:beats_per_minute].to_i      unless meta[:beats_per_minute].nil?
    #temp_album_name       = meta[:album].to_s                 unless meta[:album].nil?           
    #temp_year             = meta[:year]                       unless meta[:year].nil?            
    #temp_genre            = meta[:genre]                      unless meta[:genre].nil?           
    #temp_artist           = meta[:artist]                     unless meta[:artist].nil?          
    #temp_comment          = meta[:comment]                    unless meta[:comment].nil?         
    #temp_performer        = meta[:performer]                  unless meta[:performer].nil?       
    #temp_title            = meta[:title]                      unless meta[:title].nil?           
    #temp_band             = meta[:band]                       unless meta[:band].nil?            
    #temp_disc             = meta[:disc]                       unless meta[:disc].nil?            
    #temp_track            = meta[:track]                      unless meta[:track].nil?    
    #
    #
    #self.duration         = temp_duration     if self.duration.to_s == 0   && temp_duration  
    #self.lyrics           = temp_lyrics       if self.lyrics.to_s == ''    && temp_lyrics     
    #self.bpm              = temp_bpm          if self.bpm.to_s == ''       && temp_bpm        
    #self.album_name       = temp_album_name   if self.album_name.to_s == ''&& temp_album_name 
    #self.year             = temp_year         if self.year.to_s == ''      && temp_year       
    #self.genre            = temp_genre        if self.genre.to_s == ''     && temp_genre      
    #self.artist           = temp_artist       if self.artist.to_s == ''    && temp_artist     
    #self.comment          = temp_comment      if self.comment.to_s == ''   && temp_comment    
    #self.performer        = temp_performer    if self.performer.to_s == '' && temp_performer  
    #self.title            = temp_title        if self.title.to_s == ''     && temp_title      
    #self.band             = temp_band         if self.band.to_s == ''      && temp_band       
    #self.disc             = temp_disc         if self.disc.to_s == ''      && temp_disc       
    #self.track            = temp_track        if self.track.to_s == ''     && temp_track  
    

    save!       
  end
  
  #def apply_common_work
  #  
  #  
  #  unless common_work
  #    CommonWork.create(account_id: self.account_id, title: self.title, lyrics: self.lyrics)
  #  end
  #    
  #end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
private
  #def update_counter_cache
  #  self.content_type = document.file.content_type
  #end
  
  def flush_cache
    account.rec_cache_version += 1
    account.save!
    Rails.cache.delete([self.class.name, id])
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
