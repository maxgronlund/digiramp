# encoding: UTF-8
require 'fileutils'

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
                                      #:comment, 
                                      :vocal, 
                                      :isrc_code,
                                      :copyright,
                                      :production_company,
                                      :upc_code,
                                      :year,
                                      :album_name,
                                      :performer,
                                      :band,
                                      #:mood,
                                      :instruments,
                                      :tempo 
                                    ], 
                            using: {  
                                      tsearch: { prefix: true, 
                                                 any_word: true, 
                                                 dictionary: "english"
                                                },
                                      dmetaphone: {:any_word => true, :sort_only => true}
                                      
                                    }
                                    #,
                            #ignoring: :accents
                                    
  #pg_search_scope :search, against: [ :title, 
  #                                    :composer,
  #                                    :lyrics, 
  #                                    :genre, 
  #                                    :artist, 
  #                                    :bpm, 
  #                                    :comment, 
  #                                    :vocal, 
  #                                    :isrc_code,
  #                                    :copyright,
  #                                    :production_company,
  #                                    :upc_code,
  #                                    :year,
  #                                    :album_name,
  #                                    :performer,
  #                                    :band,
  #                                    :mood,
  #                                    :instruments,
  #                                    :original_file_name,
  #                                    :tempo 
  #                                  ], using:  [:tsearch ]
  #
  #
  
  validates :title, :presence => true
  #validates :acceptance_of_terms, acceptance: true
  
  scope :bucket,            -> { where( in_bucket: true)  }
  scope :not_in_bucket,     -> { where.not( in_bucket: true)  }
  scope :public_access,     -> { where(privacy: 'Anyone')}
  scope :private_access,    -> { where(privacy: 'Only me')}
  scope :invited_access,    -> { where(privacy: 'Only people I choose')}
  scope :account_access,    -> { where(privacy: 'Only people I invite to my account')}
  
  belongs_to :account
  belongs_to :common_work
  belongs_to :import_batch
  belongs_to :user
  
  has_many :comments,        as: :commentable,          dependent: :destroy
  has_many :share_on_facebooks
  has_many :share_on_twitters
  
  
  #has_many :genre_tags
  #has_many :recordings, through: :genre_tags
  
  has_many :genre_tags,      as: :genre_tagable,        dependent: :destroy
  has_many :instrument_tags, as: :instrument_tagable,   dependent: :destroy
  has_many :mood_tags,       as: :mood_tagable,         dependent: :destroy
  
  
  has_many :image_files,                                dependent: :destroy
  has_many :recording_items,                            dependent: :destroy
  has_many :recording_ipis,                             dependent: :destroy
  accepts_nested_attributes_for :recording_ipis, :reject_if => :all_blank, :allow_destroy => true
  has_many :playbacks,                                  dependent: :destroy
  has_many :recording_views,                            dependent: :destroy
  has_many :likes,                                      dependent: :destroy
  #has_and_belongs_to_many :recordings,                  dependent: :destroy
  
  #before_save :update_uuids
  after_commit :flush_cache
  before_destroy :remove_from_collections
  #before_create :check_default_image
  #before_save :check_default_image

  
  # owners followers gets a new post on their dashboard
  has_many      :follower_events, as: :postable,    dependent: :destroy

  has_many :playlists_recordings
  has_many :catalogs, :through => :playlists_recordings
  

  before_save :uniqify_fields
  
  def uniqify_fields
    self.uniq_title              = self.title.to_uniq
    begin
      self.uniq_position           = self.position.to_uniq
    rescue
    end
    self.uniq_playbacks_count    = self.playbacks_count.to_uniq
    self.uniq_likes_count        = self.likes_count.to_uniq
  end
  
  mount_uploader :default_cover_art, ArtworkUploader
  
  

  
  VOCAL = [ "Female", "Male", "Female & Male", "Urban", "Rap", "Choir", "Child", "Spoken", "Instrumental" ]
  TEMPO = [ "Fast", "Laid Back", "Steady Rock", "Medium", "Medium-Up", "Ballad", "Brisk", "Up", "Slowly", "Up Beat" ]
  
  PRIVACY = [ "Anyone", "Only me", "Only people I choose", 'Only people I invite to my account']
  
  VOCAL_HASH = []
  
  VOCAL.each do |k|
    VOCAL_HASH << [k,k]
  end
  


  

  
  def check_default_image
    #unless File.exist?(Rails.root.join('public' +  self.default_cover_art.to_s))
    if(self.cover_art.to_s == "" || self.cover_art.include?('recording/default_cover_art'))
      prng      = Random.new
      random_id =  prng.rand(12)
    
      if random_id < 10
        random_id = '0' + random_id.to_s 
      end
      self.default_cover_art = File.open(Rails.root.join('app', 'assets', 'images', "recording-fallbacks/recording_#{random_id.to_s}.jpg"))
      self.default_cover_art.recreate_versions!
      self.save!
    end
  end
  
  def get_artwork
    self.cover_art.to_s == '' ?  self.default_cover_art_url(:size_184x184 ) : self.cover_art
    #begin
    #  art = Artwork.cached_find(self.image_file_id)
    #  return art.file
    #rescue
    #  return self.cover_art     unless self.cover_art == ''
    #  return self.artwork       unless self.artwork.to_s ==''
    #  return self.get_cover_art unless self.get_cover_art == ''
    #end
    #
    #return 'https://digiramp.com' + default_image.recording_artwork_url(:size_184x184).to_s
  end
  
  # for some reason this is not working
  # forget about it until elastic transcoding is implemented
  def update_thumbs
    File.open(self.cover_art) do |f|
      self.default_cover_art = f
      self.default_cover_art.recreate_versions!
      self.save!
    end
  end
  
  def get_cover_art
    
    self.cover_art.to_s == '' ?  self.default_cover_art_url(:size_184x184 ) : self.cover_art 
    #begin
    #  system_settings = SystemSetting.first_or_create
    #  system_settings.recording_artwork_id
    #  default_image   = DefaultImage.find(system_settings.recording_artwork_id)
    #  return 'https://digiramp.com' + default_image.recording_artwork_url(:size_184x184).to_s
    #  #https://digiramp.com/uploads/default_image/recording_artwork/3/size_184x184_logo-03.jpg'
    #rescue
    #  return ''
    #end
  end
  
  def get_cover_thumb
    self.cover_art.to_s == '' ?  self.default_cover_art_url(:size_62x62 ) : self.cover_art 
  end
  
  
  def send_notifications_on_create
    #attach_to_common_work
    #notify_followers 'Has uploaded a recording', self.user_id 
    Activity.notify_followers( 'Uploaded this recording', self.user_id, 'Recording', self.id )
    #confirm_ipis
  end

  #def notify_followers notification, user_id, postable_type, postable_id
  #
  #  Activity.notify_followers( notification, user_id, 'Recording', self.id ) if self.privacy == "Anyone"
  #
  #end
  
  #def send_notification  notification, user_id
  #  FollowerEvent.create(  user_id:               user_id,
  #                         body:                  notification,
  #                         postable_type:         'Recording',
  #                         postable_id:           self.id  
  #                        )
  #  
  #end
  
  def confirm_ipis
    #ap '======================= confirm_ipis ============================'
    self.recording_ipis.where(confirmed: false).each do |recording_ipi|
      unless recording_ipi.email  == ''
        confirm_ipi recording_ipi
      end
    end
  end
  
  def confirm_ipi recording_ipi
    #if user = User.where(email: recording_ipi.email)
    #  #ap '======================= send email to existing  user ============================'
    #  #IpiMailer.delay.confirm_recording(recording_ipi.id)
    #elsif
    #  #ap '========================== create account for new user =========================='
    #  
    #end
  end
  
  def user_credits
    begin
      self.common_work.user_credits + UserCredit.where(ipiable_id: recording_ipi_ids, ipiable_type: 'RecordingIpi', show_credit_on_recordings: true, confirmation: "Accepted")
    rescue
    end
  end
  
  def total_share
    share = 0.0
    self.recording_ipis.each do |recording_ipi|
      share += recording_ipi.share.to_f
    end
    share
  end

  def playlist 
  end
  

  
  def docs
    Document.where(documentable_id: self.id, documentable_type: 'Recording')
  end
  
  def artworks
    artwork_ids = RecordingItem.where(recording_id: self.id, 
                                      itemable_type: 'Artwork').pluck(:itemable_id)
                                      
    Artwork.where(id: artwork_ids )
    
  end
  
  #def artwork
  #  self.cover_art || 'default-cover.jpg'
  #end
  
  def has_meta_data?
    return true unless self.genre       == ''
    return true unless self.mood        == ''
    return true unless self.instruments == ''
    false
  end
  
  def has_artists?
    return true unless self.composer   == ''
    return true unless self.artist     == ''
    return true unless self.band       == ''
    return true unless self.performer  == ''
    false
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
  
  def self.recordings_search(recordings, query)
    if query.present?
     return recordings.search(query)
    end
    recordings
  end
  
  def self.search_recordings( query)
    if query.present?
     return search(query)
    else
      return all
    end
  end
  
  # remove disk_number, disk_count, track_count, available_date
  def update_completeness
    RecordingCompleteness.update self
  end
  
  def in_good_condition?
    self.completeness_in_pct > 30
  end
  
  def build_permissions

  end
  
  def extract_metadata
    RecordingExtractMetadata.extract self
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
    RecordingCsvParser.process( all )

  end
  
  def self.import_csv(csv_file)
    RecordingCsvImporter.process recording, csv_file
  end
  
  def next_step
    
  end
  
  
  
  def get_comment
    return self.comment unless self.comment.to_s == ''
    return 'Provided by DigiRAMP'
  end
  
  
  
  
  def attach_to_common_work
    if self.common_work
      CommonWork.attach self, self.account_id, self.user
    end
    self.common_work
  end
  

  
  #def get_full_size_artwork
  #  
  #  begin
  #    return Artwork.cached_find(self.image_file_id).file 
  #  rescue
  #  end
  #  begin
  #    return self.audio_upload[:artwork]
  #  rescue
  #  end
  #  self.cover_art
  #end
  
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
    
    InstrumentExtracter.process self
    # store old  tag id's so we can delete unused
    #instrument_tag_ids      = self.instrument_tags.pluck(:id)
    #new_instrument_tag_ids  = []
    #
    ## read comma seperated list
    #self.instruments.split(',').each do |instrument|
    #
    #  # find or create genre
    #  extracted_instrument = Instrument.where(title: instrument.strip)
    #                                    .first_or_create(
    #                                          title: instrument.strip, 
    #                                          user_tag: true, 
    #                                          category: 'User Instrument')
    #  
    #  # find or create instrument tag
    #  instrument_tag = InstrumentTag.where(  instrument_id: extracted_instrument.id, 
    #                                         instrument_tagable_type: self.class.to_s, 
    #                                         instrument_tagable_id: self.id)
    #                                         .first_or_create(
    #                                           instrument_id: extracted_instrument.id, 
    #                                           instrument_tagable_type: self.class.to_s, 
    #                                           instrument_tagable_id: self.id
    #                                        )
    #  # store used tag ids
    #  new_instrument_tag_ids << instrument_tag.id
    #end
    ## remove not used tags
    #if instrument_tags = InstrumentTag.where(id: (instrument_tag_ids - new_instrument_tag_ids))
    #  instrument_tags.destroy_all
    #end
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
  
  
  
  
  
  #Rails.application.secrets.s3_key_id, # ENV["S3_KEY_ID"] , 
  #Rails.application.secrets.s3_access_key, # 3ENV["S3_ACCESS_KEY"],
  #Rails.application.secrets.aws_s3_region
  #
  #Rails.application.secrets.aws_s3_bucket  #ENV["AWS_S3_BUCKET"]
  
  
  
  # add this to environment variables
  # read from yaml file
  def download_url(style = nil, expires_in = 90.minutes)
    self.mp3
    #begin
    #  ap Rails.application.secrets.aws_s3_bucket
    #  #Aws.config(access_key_id: Rails.application.secrets.s3_key_id,  secret_access_key: Rails.application.secrets.s3_access_key ) 
    #  #s3 = Aws::S3::Client.new
    #  s3 = Aws::S3::Resource.new
    #  
    #  #ap s3.operation_names
    #  #ap s3.list_buckets
    #  
    #  bucket = s3.bucket(Rails.application.secrets.aws_s3_bucket)
    #  ap bucket
    #  
    #  #ap s3.list_buckets
    #  
    #  #bucket = s3.bucket(bucket: Rails.application.secrets.aws_s3_bucket) 
    #  #ap bucket
    #  #bucket = s3.bucket(Rails.application.secrets.aws_s3_bucket) # makes no request
    #  #if self.mp3.include?("https://s3-us-west-1.amazonaws.com/digiramp/")
    #  #  bucket.objects[self.mp3.gsub('https://s3-us-west-1.amazonaws.com/digiramp/', '')].url_for(:read, :secure => true, :expires => expires_in)
    #  #else
    #  #  bucket.objects[self.mp3.gsub('https://digiramp.s3.amazonaws.com/', '')].url_for(:read, :secure => true, :expires => expires_in)
    #  #end
    #rescue Aws::S3::Errors => e
    #  ap 'autch'
    #  ap e.inspect
    #end
  end
  
  def widget_snippet widget_url
    "<iframe width='100%' height='166' src='#{widget_url}' frameborder='0' allowfullscreen></iframe>"
  end
  
  def zip
    begin
      logger.info '========================================= ZIPPING =================================================='
      folder = UUIDTools::UUID.timestamp_create().to_s
      new_dir = FileUtils.mkdir_p( Rails.root.join("public", "uploads", "recordings", "zip", folder ).to_s )
      
      
      temp_file = Tempfile.new("recording-zip-#{UUIDTools::UUID.timestamp_create().to_s}")
        Zip::OutputStream.open(temp_file.path) do |z|
          title = self.original_file_name
          z.put_next_entry("#{self.title}/#{title}")
          url1_data = open(self.mp3)
          z.print IO.read(url1_data)
        end
      
        
        file = File.open(Rails.root.join("public", "uploads", "recordings", "zip", folder ,"#{self.title}.zip"), "w+b")
        file.write(temp_file.read)
        
        self.zipp =  "uploads/recordings/zip/" + folder + '/' +  self.title + ".zip"
        self.save
      temp_file.close
    
    
    rescue Exception => e  
      #logger.info '.'
      #logger.info '.'
      #logger.info '.'
      #logger.info '========================================= ERROR ZIPPING =================================================='
      #logger.info '=========================================================================================================='
      #logger.info self.id
      #logger.info self.title
      ##logger.info e.backtrace.inspect
      #logger.info '...'
      #logger.info '...'
      #logger.info '...'
      #logger.info '...'
      #logger.info '...'
    end
    #sleep(20)
    #ZipRecordingsWorker.perform_async()

  end
  
  def transfer_commonwork

    if self.account_id != self.common_work.account_id
      
      common_work_copy = self.account.common_works.where(uuid: self.common_work.uuid)
                                   .first_or_create(
                                      title:                               self.common_work.title,
                                      iswc_code:                           self.common_work.iswc_code,                      
                                      ascap_work_id:                       self.common_work.ascap_work_id,
                                      account_id:                          self.account_id,
                                      common_works_import_id:              nil,
                                      audio_file:                          nil,
                                      content_type:                        self.common_work.content_type,
                                      description:                         self.common_work.description,
                                      alternative_titles:                  self.common_work.alternative_titles,
                                      recording_preview_id:                nil,
                                      step:                                self.common_work.step,                             
                                      lyrics:                              self.common_work.lyrics,
                                      catalog_id:                          self.common_work.catalog_id,
                                      uuid:                                self.common_work.uuid,
                                      completeness:                        self.common_work.completeness,
                                      artwork:                             nil,
                                      pro:                                 self.common_work.pro,
                                      surveyed_work:                       self.common_work.surveyed_work,
                                      last_distribution:                   self.common_work.last_distribution,
                                      work_status:                         self.common_work.work_status,
                                      ascap_award_winner:                  self.common_work.ascap_award_winner,
                                      work_type:                           self.common_work.work_type,
                                      composite_type:                      self.common_work.composite_type,
                                      arrangement:                         self.common_work.arrangement,
                                      genre:                               self.common_work.genre,
                                      submitter_work_id:                   self.common_work.submitter_work_id,
                                      registration_date:                   self.common_work.registration_date,                
                                      bmi_work_id:                         self.common_work.bmi_work_id,                      
                                      bmi_catalog:                         self.common_work.bmi_catalog,                      
                                      registration_origin:                 self.common_work.registration_origin,              
                                      pro_work_id:                         self.common_work.pro_work_id,                      
                                      pro_catalog:                         self.common_work.pro_catalog
                                      )
    
    
    common_work_copy.copy_ipis_from( self.common_work )
    
    self.common_work_id = common_work_copy.id
    self.save!
    
    

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

  end
  
  def count_stats_down

  end
  
  
  
  def remove_from_collections
    update_uuids
    remove_from_catalogs
    remove_from_albums
    count_stats_down
    remove_from_submissions
    remove_from_playlists
    remove_share_on_facebooks
  end
  
  
  
  def remove_share_on_facebooks
    begin
      self.share_on_facebooks.destroy_all
    rescue
    end
    
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
  
  def remove_from_playlists
    PlaylistRecordings.where(recording_id: self.id).destroy_all
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
    #self.title = self.title.strip
    ##AccountCache.update_works_uuid self.account
    #AccountCache.update_recordings_uuid(self.account) if self.account_id
    #self.uuid = UUIDTools::UUID.timestamp_create().to_s
    #self.uniq_title = self.title.to_uniq
  end
  
  
  
  
  
end
