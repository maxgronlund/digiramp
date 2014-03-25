class CommonWork < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search, against: [:title, :lyrics, :alternative_titles, :iswc_code, :description ], :using => [:tsearch]
  
  belongs_to :account
  #belongs_to :ascap_import
  #belongs_to :common_work_import
  
  has_many :recordings, dependent: :destroy
  accepts_nested_attributes_for  :recordings, allow_destroy: true
  
  
  
  has_many :attachments, as: :attachable
  
  
  has_many :ipis,       dependent: :destroy
  
  #has_many :activity_events, as: :activity_eventable
  #has_many :documents,       as: :documentable, dependent: :destroy
  has_many :work_users, dependent: :destroy
  
  #mount_uploader :audio_file, AudioFileUploader
  before_save :update_audio_file_attributes
  after_commit :flush_cache
  
  
  #title @@ :q or lyrics @@ :q or alternative_titles @@ :q or iswc_code @@ :q or description

  #before_save :check_title
  
  def audio_recordings 
    recordings.where(media_type: 'recording') 
  end
  
  def video_recordings 
    recordings.where(media_type: 'video') 
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
    recording.save!
  end
  
  def self.account_search(account, query)
    common_works = account.common_works
    if query.present?
     common_works = common_works.search(query)
    end
    common_works
  end
  
  def is_accessible_by user
    return true  if user.can_manage 'access works', account
    return true
    
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end


private
  #def update_counter_cache
  #  self.content_type = document.file.content_type
  #end
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  def update_audio_file_attributes
    if audio_file.present? && audio_file_changed?
      
      self.content_type = audio_file.file.content_type
      self.file_size = audio_file.size
      #fo
      
    end
  end
  

  
end
