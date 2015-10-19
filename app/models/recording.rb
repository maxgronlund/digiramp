# encoding: UTF-8
require 'fileutils'

class Recording < ActiveRecord::Base
  include PublicActivity::Common
  include ErrorNotification
  # virtual parameter for CommonWorksController#new_recording form
  
  attr_accessor :add_to_catalogs
  mount_uploader :default_cover_art, ArtworkUploader
  
  
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
  has_many   :products, class_name: "Shop::Product"
  
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
  #accepts_nested_attributes_for :recording_ipis, :reject_if => :all_blank, :allow_destroy => true
  has_many :playbacks,                                  dependent: :destroy
  has_many :recording_views,                            dependent: :destroy
  has_many :likes,                                      dependent: :destroy
  has_many :recording_users
  
  has_many :label_recordings
  has_many :labels,  :through => :label_recordings  

  before_save :uniqify_fields
  after_commit :flush_cache
  #after_create :notify_followers
  before_destroy :remove_from_collections
  
  #before_create :check_default_image
  #before_save :check_default_image

  
  # owners followers gets a new post on their dashboard
  has_many :follower_events, as: :postable,    dependent: :destroy

  has_many :playlists_recordings
  has_many :catalogs, :through => :playlists_recordings
  
  VOCAL = [ "Female", "Male", "Female & Male", "Urban", "Rap", "Choir", "Child", "Spoken", "Instrumental" ]
  TEMPO = [ "Fast", "Laid Back", "Steady Rock", "Medium", "Medium-Up", "Ballad", "Brisk", "Up", "Slowly", "Up Beat" ]
  
  #PRIVACY = [ "Anyone", "Only me", "Only people I choose", 'Only people I invite to my account']
  PRIVACY = [ "Anyone", "Only me", "Only people I choose"]
  #PRIVACY = [ "Anyone", "Only me"]
  
  VOCAL_HASH = []
  
  VOCAL.each do |k|
    VOCAL_HASH << [k,k]
  end
  
  def stakes
    Stake.where(asset_type: self.class.name,asset_id: self.uuid )
  end
  
  
  
  
  # move this to stake or service object
  #def update_stakes recording
  #
  #  self.get_common_work.ipis.each do |ipi|
  #    if stake = Stake.find_by(
  #                              account_id:   ipi.get_account_id,
  #                              asset_id:     recording.uuid,
  #                              asset_type:   recording.class.name,
  #                              ip_uuid:      ipi.uuid,
  #                              ip_type:      ipi.class.name
  #                             )
  #    else
  #      stake = Stake.create(  
  #                              account_id:          ipi.get_account_id,
  #                              asset_id:            recording.uuid,
  #                              asset_type:          recording.class.name,
  #                              split:               ipi.share * 0.5,
  #                              flat_rate_in_cent:   0,
  #                              currency:            'usd',
  #                              email:               ipi.user.email,
  #                              unassigned:          false,
  #                              ip_uuid:             ipi.uuid,
  #                              ip_type:             ipi.class.name
  #                          )
  #    end
  #
  #  end
  #  
  #  self.recording_ipis.each do |recording_ipi|
  #    if stake = Stake.find_by( account_id:          recording_ipi.account_id, 
  #                              ip_uuid:             recording_ipi.uuid,
  #                              ip_type:             recording_ipi.class.name,
  #                              asset_id:            recording.uuid,
  #                              asset_type:          recording.class.name
  #                             )
  #      
  #      
  #    else stake = Stake.create( account_id:          recording_ipi.account_id, 
  #                               ip_uuid:             recording_ipi.uuid,
  #                               ip_type:             recording_ipi.class.name,
  #                               asset_id:            recording.uuid,
  #                               asset_type:          recording.class.name,
  #                               split:               recording_ipi.share * 0.5,
  #                               flat_rate_in_cent:   0,
  #                               currency:            'usd',
  #                               email:               recording_ipi.email,
  #                               unassigned:          false,
  # 
  #                              )
  #                             
  #    end
  #
  #    
  #  end
  #  
  #end
  
  #def update_stakes
  #  #begin
  #  #  if shop_products = Shop::Product.where(productable_id: self.id,  productable_type: self.class.name)
  #  #     shop_products.update_all(title: self.title)
  #  #  end
  #  #rescue => e
  #  #  post_error "Recording#update_stakes #{e.message}"
  #  #end
  #end
  
  
  def is_cleared?
    #ap "get_common_work.is_cleared?: #{get_common_work.is_cleared?}"
    ap "master_is_cleared?: #{master_is_cleared?}"
    return false unless get_common_work.is_cleared?
    return false unless master_is_cleared?
    
    true
  end
  
  def master_is_cleared?
    
    ap "ipis_is_registered?: #{ipis_is_registered?}"

    return false unless ipis_is_registered?
    recording_ipis.each do |recording_ipi|
      #ap "recording_ipi.accepted?: #{recording_ipi.accepted?}"
      return false unless recording_ipi.accepted?
    end
    true
  end
  
  def ipis_is_registered?
    recording_ipis.count > 0
  end
  
  
  def get_common_work
    self.common_work ? self.common_work : self.mount_common_work 
  end
   
  def product
    Shop::Product.find_by(productable_id: self.id, productable_type: 'Recording')
  end
  
  def for_sale_in_shop?
    return false unless self.is_cleared?
    if product_in_shop = product
      return product_in_shop if product_in_shop.for_sale
    end
    nil
  end
  
  #def stakes
  #  stks =  Stake.where( asset_id: self.id,             asset_type: 'Recording' )
  #  stks += Stake.where( asset_id: self.common_work_id, asset_type: 'CommonWork')
  #end
  
  def contributors_share
    ps = 0.0
    self.recording_ipis.each do |recording_ipi|
      ps += recording_ipi.share
    end
    ps
  end
  
  
  #def validate_splits
  #  #total = 0.0
  #  #self.stakes.each do |stake|
  #  #  total += stake.split_in_percent
  #  #end
  #  #return total == 1.0
  #end

  def uniqify_fields
    self.uniq_title              = self.title.to_uniq
    begin
      self.uniq_position         = self.position.to_uniq
    rescue
    end
    self.uniq_playbacks_count    = self.playbacks_count.to_uniq
    self.uniq_likes_count        = self.likes_count.to_uniq
    self.uuid = UUIDTools::UUID.timestamp_create().to_s if self.uuid.nil?
  end
  
  def notify_followers
    if self.privacy == 'Anyone' && Rails.env.production?
      FollowerMailer.delay_for(40.minutes).recording_uploaded( self.id )
    end
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
    self.cover_art.blank? ?  self.default_cover_art_url(:size_184x184 ) : self.cover_art
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
  
  def mount_common_work
    unless self.common_work
      common_work = CommonWork.create( account_id: self.account_id, 
                                       title:      self.title, 
                                       lyrics:     self.lyrics)
              
      self.common_work_id = common_work.id
      self.save(validate: false)
    end
    common_work
  end

  
  def get_shop_art
    self.cover_art.blank? ?  self.default_cover_art_url(:size_184x184 ) : self.cover_art 
  end
  
  def get_cover_art
    self.cover_art.blank? ?  self.default_cover_art_url(:size_184x184 ) : self.cover_art 
  end
  
  def get_cover_thumb
    self.cover_art.blank? ?  self.default_cover_art_url(:size_62x62 ) : self.cover_art 
  end
  
  def confirm_ipis

    self.recording_ipis.where(confirmed: false).each do |recording_ipi|
      unless recording_ipi.email  == ''
        confirm_ipi recording_ipi
      end
    end
  end
  
  def confirm_ipi recording_ipi

  end
  
  def user_credits
    #begin
    #  self.common_work.user_credits + UserCredit.where(ipiable_id: recording_ipi_ids, 
    #                                                   ipiable_type: 'RecordingIpi', 
    #                                                   show_credit_on_recordings: true, 
    #                                                   confirmation: "Accepted")
    #rescue
    #  
    #  ErrorNotification.post "Recording#user_credits: recording_id: #{self.id}"
    #end
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

  # update the genre
  def extract_genres
    GenreExtracter.process self
  end

  # update instruments
  def extract_instruments 
    InstrumentExtracter.process self
  end
  
  def extract_moods
    MoodExtracter.process self
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
    
    s3 = Aws::S3::Resource.new

    secure_url = self.mp3
    
    unless Rails.env.test?
      begin
        if self.mp3.include?("https://s3-us-west-1.amazonaws.com/digiramp/")
          secure_url = self.mp3.gsub('https://s3-us-west-1.amazonaws.com/digiramp/', '')
        else
          secure_url = self.mp3.gsub('https://digiramp.s3.amazonaws.com/', '')
        end
        
        bucket      = s3.bucket(Rails.application.secrets.aws_s3_bucket)
        s3_obj      = bucket.object(secure_url)
        secure_url  = s3_obj.presigned_url(:get, expires_in: 600)
      rescue => e

        secure_url = self.mp3
      end
    end
    secure_url
  end
  
  # example from http://docs.aws.amazon.com/sdkforruby/api/index.html
  def download_url2
    s3 = Aws::S3::Resource.new
    secure_url = self.mp3

    begin
      if self.mp3.include?("https://s3-us-west-1.amazonaws.com/digiramp/")
        secure_url = self.mp3.gsub('https://s3-us-west-1.amazonaws.com/digiramp/', '')
      else
        secure_url = self.mp3.gsub('https://digiramp.s3.amazonaws.com/', '')
      end
      bucket      = s3.bucket(Rails.application.secrets.aws_s3_bucket)
      s3_obj      =  bucket.object(secure_url)
      filename    = self.title.downcase.gsub(' ', '-') + '.mp3'
      secure_url  = s3_obj.presigned_url(:get, expires_in: 600,response_content_disposition: "attachment; filename='#{filename}'")
    rescue => e
      ap e.inspect
      secure_url = self.mp3
    end
    secure_url
  end
  
  
  def widget_snippet widget_url
    "<iframe width='100%' height='166' src='#{widget_url}' frameborder='0' allowfullscreen></iframe>"
  end
  
  def zip
   
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
  
  def remove_from_collections
    update_uuids
    remove_from_catalogs
    remove_from_albums
    count_stats_down
    remove_from_submissions
    remove_from_playlists
    remove_share_on_facebooks
    remove_from_follower_events
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
  
  def remove_from_follower_events
    if followed_events = FollowerEvent.where(postable_type: 'Recording', postable_id: self.id)
      followed_events.destroy_all
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
    #self.title = self.title.strip
    ##AccountCache.update_works_uuid self.account
    #AccountCache.update_recordings_uuid(self.account) if self.account_id
    #self.uuid = UUIDTools::UUID.timestamp_create().to_s
    #self.uniq_title = self.title.to_uniq
  end
  
  
  
  
  
end
