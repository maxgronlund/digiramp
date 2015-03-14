# A catalog is an aggreation of catalog items
# A catalog always has one widget so it can be shown
# The widget is refered true a UUID 'uuid'

class Catalog< ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :account
  has_many :catalog_items, dependent: :destroy
  has_many :catalog_users, dependent: :destroy
  
  has_many :common_works_imports, dependent: :destroy
  has_many :widgets, dependent: :destroy
  
  has_and_belongs_to_many :common_works
  has_and_belongs_to_many :recordings
  has_and_belongs_to_many :artworks
  has_and_belongs_to_many :documents
  
  ASSTE_TYPES = ['CommonWork', 'Recording', 'Document']
  
  mount_uploader :image, CatalogUploader

  #belongs_to :catalog_itemable, polymorphic: true
  #attr_accessible :catalog_itemable_type, :catalog_itemable_id, :account_catalog_id
  
  #before_save  :update_uuid
  after_commit :flush_cache

  #before_destroy :remove_account_users
  after_create   :add_related_objects
  
  def add_related_objects
    AccessManager.add_account_users_to_catalog self
    self.uuid     = UUIDTools::UUID.timestamp_create().to_s
    self.save
    default_playlist
    check_default_image
  end
  
  
  def check_default_image
    if self.image_url == "/assets/fallback/catalog.jpg" || self.image.to_s == '' || self.image.nil?
      prng      = Random.new
      random_id =  prng.rand(12)

      if random_id < 10
        random_id = '0' + random_id.to_s 
      end
      self.image = File.open(Rails.root.join('app', 'assets', 'images', "default-accounts/default_#{random_id.to_s}.jpg"))
      puts '1'
      self.image.recreate_versions!
      puts '2'
      self.save!
      puts '3'
    else
      puts '4'
      self.image.recreate_versions!
      puts '5'
      self.save!
    end
    
    
    
  end
  
  
  
  def default_playlist
    Playlist.where( uuid: self.uuid)
            .first_or_create( uuid:       self.uuid,
                              user_id:    self.user_id,
                              account_id: self.account_id,
                              title:      self.title,
                              body:       self.body,
                              url:        UUIDTools::UUID.timestamp_create().to_s,
                              url_title:  self.title,
                              link_title: self.title
                            )


  end
  
  def update_widget
    default_playlist.add_items self.recordings
  end
  
  def default_widget 
    default_playlist.default_widget
  end

  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def update_assets_count
    self.count_recordings
    self.count_common_works
    self.count_assets
    self.count_users
    self.save!
  end
  
  # counter cache
  def count_recordings
    self.nr_recordings  = self.catalog_items.where(catalog_itemable_type: 'Recording').count
  end
  
  # counter cache
  def count_common_works
    self.nr_common_works = self.common_works.count

  end
  
  # counter cache
  def count_assets
    #puts '-----------------------count_assets ---------------------------------'
    self.nr_assets = self.catalog_items.where(catalog_itemable_type: ['Document', 'Artwork']).count
  end
  
  # counter cache
  def count_users
    self.nr_users = self.catalog_users.where(role: ['Catalog User', 'Account Owner']).count
  end
  

  
  def add_artwork artwork
    ArtworksCatalogs.where(artwork_id: artwork.id, catalog_id: self.id)
                      .first_or_create(artwork_id: artwork.id, catalog_id: self.id)
  end
  
  def attach_recordings recordings_to_attach
    ap recordings_to_attach
    ap recordings_to_attach.class.name
    recordings_to_attach.each do |recording|
      attach_recording recording
    end
  end


  # add a recording to the catalog
  # after added also create a catalog item for the common work
  def attach_recording recording
    CatalogsRecordings.where(catalog_id: self.id, recording_id: recording.id)
                      .first_or_create(catalog_id: self.id, recording_id: recording.id)
  end
  
  
  
  # add a common work to a catalog
  def add_common_work common_work
    CatalogsCommonWorks.where(catalog_id: self.id, common_work_id: common_work.id)
                      .first_or_create(catalog_id: self.id, common_work_id: common_work.id)
                      
    common_work.recordings.each do |recording|
      self.attach_recording recording
    end
  end

  # when a new catalog is created add account users
  # when a new account user is created add the user
  # when a user is updated to super add the user
  def add_account_user account_user
   
    
    # find or create catalog user
    catalog_user = CatalogUser.where(   user_id: account_user.user_id, 
                                        catalog_id: self.id,
                                        account_id: self.account_id,
                                        role: account_user.role)
                                .first_or_create(  
                                        user_id: account_user.user_id, 
                                        catalog_id: self.id,
                                        account_id: self.account_id,
                                        role: account_user.role
                                      )
    
    # copy permissions to catalog user                                    
    Permissions::TYPES.each do |permission|
      #eval "catalog_user.#{permission} = account_user.#{permission}"
      catalog_user[permission] = account_user[permission]
    end
    catalog_user.save!
    catalog_user
  end
  
  
private

  def update_uuid
    self.uuid = UUIDTools::UUID.timestamp_create().to_s
  end
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  #def remove_account_users
  #  puts '----------------------------------'
  #  puts 'remove_account_users'
  #end

end
