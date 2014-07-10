class CommonWork < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search, against: [:title, :lyrics, :alternative_titles, :iswc_code, :description ], :using => [:tsearch]
  
  belongs_to :account
  #belongs_to :ascap_import
  belongs_to :common_works_import
  
  has_many :recordings, dependent: :destroy
  #accepts_nested_attributes_for  :recordings, allow_destroy: true
  
  has_many :attachments, as: :attachable,       dependent: :destroy
  has_many :ipis,       dependent: :destroy
  
  #has_many :activity_events, as: :activity_eventable
  #has_many :documents,       as: :documentable, dependent: :destroy
  has_many :work_users, dependent: :destroy
  
  has_many :catalog_items, as: :catalog_itemable, dependent: :destroy
  
  #mount_uploader :audio_file, AudioFileUploader
  before_save :update_uuids
  before_destroy :update_uuids
  after_commit :flush_cache
  after_create :count_statistics_up
  
  PROS = ['ASCAP', 'BMI']

  #title @@ :q or lyrics @@ :q or alternative_titles @@ :q or iswc_code @@ :q or description

  #before_save :check_title
  
  def audio_recordings 
    recordings.where(media_type: 'recording') 
  end
  
  def video_recordings 
    recordings.where(media_type: 'video') 
  end


  # if the user can edit
  def editable_by user
    recordings.each do |recording|
      return true if recording.update_common_work_ids.include?  user.id
    end
    return false
  end
  
  # if the user can access files
  def user_can_access_files user
    recordings.each do |recording|
      return true if recording.update_common_work_ids.include?  user.id
    end
    return false
  end
  
  
  def recording_genres
    genres = []
    self.recordings.includes(:genres).each do |recording|
      recording.genres.each do |genre|
        genres << genre
      end
    end
    genres.uniq!
    genres
  end
  
  def recording_moods
    moods = []
    self.recordings.includes(:moods).each do |recording|
      recording.moods.each do |mood|
        moods << mood
      end
    end
    moods.uniq!
    moods
  end
  
  def recording_instruments
    instruments = []
    self.recordings.includes(:instruments).each do |recording|
      recording.instruments.each do |instrument|
        instruments << instrument
      end
    end
    instruments.uniq!
    instruments
  end
  
  def files
    self.attachments.files
  end
  
  def legal_documents
    self.attachments.legal_documents
  end
  
  def financial_documents
    self.attachments.financial_documents
  end
  
  #def to_csv
  #  
  #  csv_string = CSV.generate do |csv|
  #    # common work info
  #    csv << ["COMMON WORK", "ID: #{self.id}"]
  #    csv << ["Title", "Alternative titles", "Description", "ISWC code", "ASCAP work id"]
  #    csv << [self.title, self.alternative_titles, self.description, self.iswc_code, self.ascap_work_id]
  #    
  #    #ipi's info
  #    csv << []
  #    csv << []
  #    csv << ["IPI'S"]
  #    csv << ["Common work id", "IPI code", "CAE code", "Full name", "Address", "Email", "Phone number", "Role", "Controlled", "Terrirory", "Share", "Mech owned", "Mech Collected", "Perf owned", "Perf collected", "Notes"]
  #    self.ipis. each do |ipi|
  #      csv << [self.id, ipi.ipi_code, ipi.cae_code, ipi.full_name, ipi.address, ipi.email, ipi.phone_number, ipi.territory, ipi.share, ipi.mech_owned, ipi.mech_collected, ipi.perf_owned, ipi.notes ]
  #    end
  #    
  #    #recordings info
  #    csv << []
  #    csv << []
  #    csv << ["RECORDINGS"]
  #    csv << ["Common work id", "Title", "ISRC", "Artists", "lyrics", "BPM", "Duration hh:mm:ss", "instrumental y/n", "Release date mm/dd/yyyy", "Description", "Explicit", "200% clearance y/n", "Copyright", "Available mm/dd/yyyy", "UPC"]
  #     self.recordings. each do |recording|
  #        csv << [self.id, recording.title, recording.isrc_code, recording.artists, recording.lyrics, recording.bpm, recording.duration, "#{recording.instrumental ? 'y':'n'}", recording.release_date, recording.comment,  "#{recording.explicit ? 'y':'n'}", "#{recording.comment ? 'y':'n'}", recording.copyright, recording.available_date, recording.upc_code ]
  #      end
  #    
  #  end
  #  csv_string
  #end
  
  def audio_preview
    Recording.find(self.recording_preview_id).audio_file_url if Recording.exists?(self.recording_preview_id)
  end
  
  def self.attach recording, account_id

    common_work = CommonWork.create(title: recording.title, 
                                    description: recording.comment, 
                                    lyrics: recording.lyrics, 
                                    account_id: account_id)
                                    
    recording.common_work_id = common_work.id
    recording.save
    common_work.update_completeness

    common_work
  end
  
  def self.account_search(account, query)
    common_works = account.common_works
    if query.present?
     common_works = common_works.search(query)
    end
    common_works
  end
  
  # find a common work in a collection
  # filter out those alreaddy in the catalog
  def self.find_from_collection(account, catalog, query)
    
    common_work_ids = CatalogItem.where(catalog_id: catalog.id, 
                                        catalog_itemable_type: 'CommonWork').pluck(:catalog_itemable_id)
                                        
    common_work_ids = account.common_work_ids - common_work_ids
    common_works = CommonWork.where(id: common_work_ids)
    
    if query.present?
     common_works = common_works.search(query)
    end
    common_works
  end
  
  # find a common work in a catalog
  def self.catalog_search(catalog, query)
    
    common_works = catalog.common_works
    if query.present?
     common_works = common_works.search(query)
    end
    common_works
  end
  
  def health
    completeness
  end
  
  def update_completeness
    value = 0
    value += 5 unless self.recordings.size.to_i      == 0
    value += 5 unless self.title.to_s                == ''
    value += 5 unless self.description.to_s          == ''
    value += 5 unless self.alternative_titles.to_s   == ''
    value += 5 unless self.iswc_code.to_s            == ''

    # 75% of the completeness is based on the recordings
    value += recording_health * 0.75
    self.completeness       = value
    self.save!

  end
  
  def recording_health
    rec_health        = 0
    recording_factor  = 1
    # if there is any recordings
    if self.recordings.exists?
      # take the average of one recording
      recording_factor = 1/recordings.size
      # loop true recordings
      self.recordings.each do |recording|
        recording.update_completeness
        
        rec_health += recording.completeness_in_pct
      end
    end
    rec_health *= recording_factor
    rec_health
  end
  
  def artworks
    CatalogItem.where(catalog_itemable_id: self.id, catalog_itemable_type: 'Artwork')
  end
  

  # access control move to helper
  
  # check if user is an associate adminstrator or owner
  #def is_accessible_by user
  #  return true if user.can_manage 'access works', account
  #  return false
  #end
  #
  ## ipis
  #def ipis_is_accessible_by user
  #  # pessimistic locking
  #  access = false
  #  if user.can_manage 'access works', account
  #    access = true
  #  elsif work_user = WorkUser.cached_where(self.id, user.id)
  #    access = true if work_user && work_user.access_ipis  
  #  end
  #  access
  #end
  #
  ## files
  #def files_is_accessible_by user
  #  # pessimistic locking
  #  access = false
  #  if user.can_manage 'access works', account
  #    access = true
  #  elsif work_user = WorkUser.cached_where(self.id, user.id)
  #    access = true if work_user && work_user.access_files  
  #  end
  #  access
  #end
  #
  ## legal documents
  #def legal_documents_is_accessible_by user
  #  # pessimistic locking
  #  access = false
  #  if user.can_manage 'access works', account
  #    access = true
  #  elsif work_user = WorkUser.cached_where(self.id, user.id)
  #    access = true if work_user && work_user.access_legal_documents  
  #  end
  #  access
  #end
  #
  ## financial documents
  #def financial_documents_is_accessible_by user
  #  # pessimistic locking
  #  access = false
  #  if user.can_manage 'access works', account
  #    access = true
  #  elsif work_user = WorkUser.cached_where(self.id, user.id)
  #    access = true if work_user && work_user.access_financial_documents  
  #  end
  #  access
  #end
  
  
  
  # model caching
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def to_csv
    # please dry this up
    CSV.generate do |csv|
      #csv << column_names
      csv << ['DigiRAMP CVS', '', '', '', '', '', '' ]
      csv << ['']
      csv << ['']
      #all.each do |common_work|
        
        #recording_ids = ''
        #common_work.recordings.each do |recording|
        #  recording_ids << recording.id.to_s
        #  recording_ids << ','
        #end
        # work info
        csv << ['COMMON WORK']
        csv << [  '','Title', 'ISWC Code','Alternative Titles', 'Description','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',  'UUID' ]
        csv << [  '',
                  self.title,
                  self.iswc_code,
                  self.alternative_titles,
                  self.description.to_s.squish,
                  '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
                  self.uuid.to_s, 
                ]
        # ipis
        #if common_work.ipis.size > 0
        if true
          csv << ['' ]
          csv << ['' ]
          csv << ['IPI\'S' ]
          csv << [  '',
                    'IPI Code',
                    'Full Name',
                    'Role', 
                    'Address', 
                    'Email', 
                    'Phone Number', 
                    'Controlled', 
                    'Territory', 
                    'Share', 
                    'Mech Owned %', 
                    'Mech Collected %', 
                    'Performance Owned %', 
                    'Performance Collected %', 
                    'Notes',
                    'CAE Code',
                    '','','','','','','','','','','','','','','','','','','', 
                    'Common Work UUID',
                  ]
          self.ipis.each do |ipi|
            csv <<  [
                      '',
                      ipi.ipi_code.to_s,
                      ipi.full_name.to_s,
                      ipi.role.to_s,
                      ipi.address.to_s,
                      ipi.email.to_s,
                      ipi.phone_number.to_s,
                      ipi.controlled.to_s,
                      ipi.territory.to_s,
                      ipi.share.to_s,
                      ipi.mech_owned.to_s,
                      ipi.mech_collected.to_s,
                      ipi.perf_owned.to_s,
                      ipi.perf_collected.to_s,
                      ipi.notes.to_s,
                      ipi.cae_code.to_s,
                      '','','','','','','','','','','','','','','','','','', '', 
                      self.uuid
                    ]
          end
          # recordings
          #if common_work.recordings.size > 0
          if true
            csv << ['' ]
            csv << ['' ]
            csv << ['RECORDINGS' ]
            csv << [  '',
                      "Title",            
                      "ISRC CODE",        
                      "Artist",                   
                      "BPM",              
                      "Comment",          
                      "Explicit",         
                      "Clearance",        
                      "Version",
                      "Copyright",        
                      "Production Company",
                      "Available Date",
                      "UPC CODE",         
                      "Album Artist",
                      "Album Title",
                      "Grouping",
                      "Composer",
                      "Compilation",
                      "Bitrate",
                      "Samplerate",
                      "Channels",
                      "Year",             
                      "Duration",         
                      "Album Name",       
                      "Genre",            
                      "Performer",        
                      "Band",             
                      "Disc",             
                      "Track", 
                      "Vocal",            
                      "Mood",             
                      "instruments",      
                      "Tempo",
                      "MP3 File",
                      'UUDI', 
                      'Common Work UUID'
                    ]
            self.recordings.each do |recording|
              csv <<  [
                        '',
                        recording.title.to_s,            
                        recording.isrc_code.to_s,        
                        recording.artist.to_s,                   
                        recording.bpm.to_s,              
                        recording.comment.to_s,          
                        recording.explicit.to_s,         
                        recording.clearance.to_s,        
                        recording.version.to_s,
                        recording.copyright.to_s,        
                        recording.production_company.to_s,
                        recording.available_date.to_s,
                        recording.upc_code.to_s,         
                        recording.album_artist.to_s,
                        recording.album_title.to_s,
                        recording.grouping.to_s,
                        recording.composer.to_s,
                        recording.compilation.to_s,
                        recording.bitrate.to_s,
                        recording.samplerate.to_s,
                        recording.channels.to_s,
                        recording.year.to_s,             
                        recording.duration.to_s,         
                        recording.album_name.to_s,       
                        recording.genre.to_s,            
                        recording.performer.to_s,        
                        recording.band.to_s,             
                        recording.disc.to_s,             
                        recording.track.to_s,      
                        recording.vocal.to_s,            
                        recording.mood.to_s,             
                        recording.instruments.to_s,      
                        recording.tempo.to_s,
                        recording.mp3,
                        recording.uuid,
                        self.uuid
                      ]
              end
            end
        end
        csv << ['']
        csv << ['']
        csv << ['']
        csv << ['']
        #end

    end
  end
  
  def self.to_csv
    CSV.generate do |csv|
      #csv << column_names
      csv << ['DigiRAMP CVS', '', '', '', '', '', '' ]
      csv << ['']
      csv << ['']
      all.each do |common_work|
        
        #recording_ids = ''
        #common_work.recordings.each do |recording|
        #  recording_ids << recording.id.to_s
        #  recording_ids << ','
        #end
        # work info
        csv << ['COMMON WORK']
        csv << [  '','Title', 'ISWC Code','Alternative Titles', 'Description','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',  'UUID' ]
        csv << [  '',
                  common_work.title,
                  common_work.iswc_code,
                  common_work.alternative_titles,
                  common_work.description.to_s.squish,
                  '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
                  common_work.uuid.to_s, 
                ]
        # ipis
        #if common_work.ipis.size > 0
        if true
          csv << ['' ]
          csv << ['' ]
          csv << ['IPI\'S' ]
          csv << [  '',
                    'IPI Code',
                    'Full Name',
                    'Role', 
                    'Address', 
                    'Email', 
                    'Phone Number', 
                    'Controlled', 
                    'Territory', 
                    'Share', 
                    'Mech Owned %', 
                    'Mech Collected %', 
                    'Performance Owned %', 
                    'Performance Collected %', 
                    'Notes',
                    'CAE Code',
                    '','','','','','','','','','','','','','','','','','','', 
                    'Common Work UUID',
                  ]
          common_work.ipis.each do |ipi|
            csv <<  [
                      '',
                      ipi.ipi_code.to_s,
                      ipi.full_name.to_s,
                      ipi.role.to_s,
                      ipi.address.to_s,
                      ipi.email.to_s,
                      ipi.phone_number.to_s,
                      ipi.controlled.to_s,
                      ipi.territory.to_s,
                      ipi.share.to_s,
                      ipi.mech_owned.to_s,
                      ipi.mech_collected.to_s,
                      ipi.perf_owned.to_s,
                      ipi.perf_collected.to_s,
                      ipi.notes.to_s,
                      ipi.cae_code.to_s,
                      '','','','','','','','','','','','','','','','','','', '', 
                      common_work.uuid
                    ]
          end
          # recordings
          #if common_work.recordings.size > 0
          if true
            csv << ['' ]
            csv << ['' ]
            csv << ['RECORDINGS' ]
            csv << [  '',
                      "Title",            
                      "ISRC CODE",        
                      "Artist",                   
                      "BPM",              
                      "Comment",          
                      "Explicit",         
                      "Clearance",        
                      "Version",
                      "Copyright",        
                      "Production Company",
                      "Available Date",
                      "UPC CODE",         
                      "Album Artist",
                      "Album Title",
                      "Grouping",
                      "Composer",
                      "Compilation",
                      "Bitrate",
                      "Samplerate",
                      "Channels",
                      "Year",             
                      "Duration",         
                      "Album Name",       
                      "Genre",            
                      "Performer",        
                      "Band",             
                      "Disc",             
                      "Track", 
                      "Vocal",            
                      "Mood",             
                      "instruments",      
                      "Tempo",
                      "MP3 File",
                      'UUDI', 
                      'Common Work UUID'
                    ]
            common_work.recordings.each do |recording|
              csv <<  [
                        '',
                        recording.title.to_s,            
                        recording.isrc_code.to_s,        
                        recording.artist.to_s,                   
                        recording.bpm.to_s,              
                        recording.comment.to_s,          
                        recording.explicit.to_s,         
                        recording.clearance.to_s,        
                        recording.version.to_s,
                        recording.copyright.to_s,        
                        recording.production_company.to_s,
                        recording.available_date.to_s,
                        recording.upc_code.to_s,         
                        recording.album_artist.to_s,
                        recording.album_title.to_s,
                        recording.grouping.to_s,
                        recording.composer.to_s,
                        recording.compilation.to_s,
                        recording.bitrate.to_s,
                        recording.samplerate.to_s,
                        recording.channels.to_s,
                        recording.year.to_s,             
                        recording.duration.to_s,         
                        recording.album_name.to_s,       
                        recording.genre.to_s,            
                        recording.performer.to_s,        
                        recording.band.to_s,             
                        recording.disc.to_s,             
                        recording.track.to_s,      
                        recording.vocal.to_s,            
                        recording.mood.to_s,             
                        recording.instruments.to_s,      
                        recording.tempo.to_s,
                        recording.mp3,
                        recording.uuid,
                        common_work.uuid
                      ]
              end
            end
        end
        csv << ['']
        csv << ['']
        csv << ['']
        csv << ['']
      end

    end
  end
  
  def add_to_catalog catalog_id

    if catalog_id
      CatalogItem.where(catalog_itemable_type: 'CommonWork', 
                        catalog_itemable_id: self.id, 
                        catalog_id: catalog_id)
                  .first_or_create(
                        catalog_itemable_type: 'CommonWork', 
                        catalog_itemable_id: self.id, 
                        catalog_id: catalog_id
                        )
    else
      puts '+++++++++++++++++++++++++++++++++++++++++++++++++'
      puts 'ERROR: Unable to add common work to catalog:' 
      puts 'In CommonWork#add_to_catalog'
      puts 'catalog_id cant be nil'
      puts '+++++++++++++++++++++++++++++++++++++++++++++++++'
    end
      
  end


private
  #def update_counter_cache
  #  self.content_type = document.file.content_type
  #end
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  def update_uuids
    #AccountCache.update_works_uuid self.account
    Statistics.first.common_works -= 1
    Statistics.first.save!
    self.uuid = UUIDTools::UUID.timestamp_create().to_s
  end
  
  def count_statistics_up
    Statistics.first.common_works += 1
    Statistics.first.save!
  end

  #def update_audio_file_attributes
  #  
  #  
  #  if audio_file.present? && audio_file_changed?
  #    
  #    #self.content_type = audio_file.file.content_type
  #    #self.file_size    = audio_file.size
  #    #fo
  #    
  #  end
  #end
  

  
end
