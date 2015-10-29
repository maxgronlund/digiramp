class CommonWork < ActiveRecord::Base
  include PublicActivity::Common
  include PgSearch
  include NotificationModule
  
  pg_search_scope :search_common_work, against: [:title, :lyrics, :alternative_titles, :iswc_code, :description ], :using => [:tsearch],  :associated_against => {
      :recordings => [ :title, 
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
                       :tempo ]
    }

  
  belongs_to :account
  belongs_to :user
  #belongs_to :ascap_import
  belongs_to :common_works_import
  
  has_many :common_work_users
  has_many :users,         :through => :common_work_users  

  
  has_many :recordings, dependent: :destroy
  #accepts_nested_attributes_for  :recordings, allow_destroy: true
  
  has_many :attachments, as: :attachable,       dependent: :destroy

  has_many :common_work_ipis
  has_many :ipis, :through => :common_work_ipis
  #has_many :user_credits, as: :ipiable
  #accepts_nested_attributes_for :ipis, allow_destroy: true
  accepts_nested_attributes_for :ipis, :reject_if => :all_blank, :allow_destroy => true
  #validates :royalty, numericality: { greater_than: 9 }
  
  
  #has_many :activity_events, as: :activity_eventable
  #has_many :documents,       as: :documentable, dependent: :destroy
  #has_many :work_users, dependent: :destroy
  
  #has_many :catalog_items, dependent: :destroy
  
  has_many :common_work_items, dependent: :destroy
  
  
  #has_many :catalog_items, as: :catalog_itemable, dependent: :destroy
  
  #mount_uploader :audio_file, AudioFileUploader
  before_save :update_uuids
  
  after_commit :flush_cache
  #after_create :add_childs
  
  has_and_belongs_to_many :catalogs
  
  has_many :notification_messages, as: :asset, dependent: :destroy
  
  #has_many :work_registrations , class_name: "Rights::WorkRegistration"
  
  
  
  PROS = ['ASCAP', 'BMI']

  #title @@ :q or lyrics @@ :q or alternative_titles @@ :q or iswc_code @@ :q or description

  #before_save :check_title
  
  #def registration
  #  self.work_registrations.first
  #end
  
  def update_publishers_payment
    begin
      self.recordings.each do |recording|
        LabelRecording.configure_payment( recording.id )
      end
    rescue => e
      ErrorNotification.post_object 'CommonWork#update_publishers_payment', e
    end
  end
  
  
  def configure_publishers_payment( price, recording_uuid )
    #ap '=========================================='
    #ap 'configure_publishers_payment'
    #ap self
    begin
      raise 'Royalty greater than price' if price < self.royalty
      
      self.common_work_ipis.each do |common_work_ipi|
        common_work_ipi.configure_payment( self.royalty , price , recording_uuid,  self.id )
      end
    rescue => e
      ErrorNotification.post_object 'CommonWork#configure_publishers_payment', e
      
      self.common_work_ipis.each do |common_work_ipi|
        common_work_ipi.configure_payment( self.royalty , self.royalty , recording_uuid, self.id )
      end
      return 0.0
    end
    price - royalty
  end
  
  def is_registered?
    return true if common_work_ipis.count > 0
  end
  
  def royalty
    10.0
  end
  
  def is_cleared?
    total_share == 100.0
    #return false if common_work_ipis.count == 0
    #self.common_work_ipis.each do |common_work_ipi|
    #  return false unless (common_work_ipi.ipi.nil?)
    #end
    #true
  end
  
  def user_id
    if self.account
      return self.account.user_id
    end
  end

  def clear_rights
    
  end
  
  def recording_id 
  end
  
  def user_credits
    #UserCredit.where(ipiable_id: ipi_ids, ipiable_type: 'Ipi', show_credit_on_recordings: true)
  end
  
  
  #def audio_recordings 
  #  recordings.where(media_type: 'recording') 
  #end
  #
  #def video_recordings 
  #  recordings.where(media_type: 'video') 
  #end


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
  
  def total_share
    common_work_ipis.sum(:share)
  end
  
  def attache_ipis_true recording_id
    self.ipis.each do |ipi|
      unless ipi.email.to_s == ''
        if user = User.where(email: ipi.email).first
          recordeing = Recording.find(recording_id)
          if recordeing.user_id == user.id
            #puts '===================================================='
            # 'DO NOTHING'
          else
            # user
          end
        end
      end
    end
    
  end

  #def audio_preview
  #  Recording.find(self.recording_preview_id).audio_file_url if Recording.exists?(self.recording_preview_id)
  #end
  
  def self.attach recording, account_id, current_user

    common_work = CommonWork.create(title: recording.title, 
                                    description: recording.comment, 
                                    lyrics: recording.lyrics, 
                                    account_id: account_id)
                                                         
    common_work.create_activity(  :created, 
                              owner: current_user,
                          recipient: common_work,
                     recipient_type: common_work.class.name,
                         account_id: account_id)
                             
    recording.common_work_id = common_work.id
    recording.save
    common_work.update_completeness

    common_work
  end
  
  def self.account_search(account, query)
    common_works = account.common_works
    if query.present?
     common_works = common_works.search_common_work(query)
    end
    common_works
  end
  
  # find a common work in a collection
  # filter out those alreaddy in the catalog
  def self.find_from_collection(account, catalog, query)

    common_works    = CommonWork.where(id: account.common_work_ids - catalog.common_work_ids)

    if query.present?
     common_works = common_works.search_common_work(query)
    end
    common_works
  end
  
  # find a common work in a catalog
  def self.catalog_search(catalog, query)
    
    common_works = catalog.common_works
    if query.present?
     common_works = common_works.search_common_work(query)
    end
    common_works
  end
  
  def health
    completeness
  end
  
  def update_completeness
    fields_count    = 0.0
    completed_count = 0.0
    

    completed_count += 1.0 unless self.recordings.size.to_i         == 0
    fields_count    += 1.0                                          
    completed_count += 1.0 unless self.title.to_s                   == ''
    fields_count    += 1.0                                          
    completed_count += 1.0 unless self.description.to_s             == ''
    fields_count    += 1.0                                          
    completed_count += 1.0 unless self.alternative_titles.to_s      == ''
    fields_count    += 1.0                                          
    completed_count += 1.0 unless self.iswc_code.to_s               == ''
    fields_count    += 1.0
    completed_count += 1.0 unless self.common_work_ipis.size.to_i   == 0
    fields_count    += 1.0

    
    update_columns(completeness: completed_count / fields_count)
    #flush_cache

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
    artwork_ids = self.common_work_items.where( attachable_type: 'Artwork').pluck(:attachable_id)
    @artworks = Artwork.where(id: artwork_ids)
  end
  

  
  
  
  # model caching
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def self.to_counter_point
     CSV.generate do |csv|
       csv << CounterPointColumns::COLUMNS
       
       all.each do |common_work|
         
         csv << [common_work.iswc_code, common_work.title ]
       end
       
       #CounterPointColumns::COLUMNS.split(/, ?/).each do |column|
       #  puts column
       #  csv << column
       #end

     end
  end

  
  def to_csv
    CommonWorkToCsvService.process [self]
  end
  
  def self.to_csv
    CommonWorkToCsvService.process all
   
  end
  
  def add_to_catalog catalog_id

    if catalog_id
      CatalogsCommonWorks.where(catalog_id: catalog_id, common_work_id: self.id)
                         .first_or_create(catalog_id: catalog_id, common_work_id: self.id)

    else
      puts '+++++++++++++++++++++++++++++++++++++++++++++++++'
      puts 'ERROR: Unable to add common work to catalog:' 
      puts 'In CommonWork#add_to_catalog'
      puts 'catalog_id cant be nil'
      puts '+++++++++++++++++++++++++++++++++++++++++++++++++'
    end
      
  end
  
  

  def update_validation
    do_validation
  end
  
  def message_hash msg
    {
      message:      msg,
      type: self.class.name,
      id:   self.id
    }
  end
  
  def error_message
    ap 'CommonWork # error_message'
    em = {}
    if total_share != 100.0
      em[:total_share] = message_hash('The creators split has to add up to 100%')
    end

    errors = []
    self.common_work_ipis.each do |common_work_ipi|
      
      unless common_work_ipi.do_validation
        errors << common_work_ipi.error_message
      end
    end
    em[:common_work_ipis] = errors unless errors.empty?
    em
  end
  
  def user
    self.account.user if self.account
  end
  
  
private
  #def update_counter_cache
  #  self.content_type = document.file.content_type
  #end
  
  def flush_cache
    update_validation unless self.destroyed?
    Rails.cache.delete([self.class.name, id])
  end
  
  
  
  def do_validation
    ap 'CommonWork # do_validation'
    
    em = error_message
    ap em
    update_columns( ok: em.empty? ) 

    self.ok ? remove_notification_message(self.user_id) :
      update_notification_message(self.user_id).update_columns( 
        error_message: em
    )
    
  end
  


  
  
  def flush_cache
    update_completeness unless self.destroyed?
    Rails.cache.delete([self.class.name, id])
  end
  
  def update_uuids

    if self.uuid.to_s == ''
      self.uuid = UUIDTools::UUID.timestamp_create().to_s
    end
  end
  
  #def add_childs
  #  work_registration     = Rights::WorkRegistration.create( common_work_id: self.id,
  #                                                           account_id:    self.account_id)
  #end

  

  
end
