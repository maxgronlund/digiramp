class Catalog< ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :account
  has_many :catalog_items, dependent: :destroy
  has_many :catalog_users, dependent: :destroy
  has_many :common_works_imports, dependent: :destroy
  has_many :widgets, dependent: :destroy
  

  #belongs_to :catalog_itemable, polymorphic: true
  #attr_accessible :catalog_itemable_type, :catalog_itemable_id, :account_catalog_id
  
  #before_save  :update_uuid
  after_commit :flush_cache

  before_destroy :remove_account_users
  after_create :add_catalog_users
  
  def add_catalog_users
    AccessManager.add_account_users_to_catalog self
  end
  
  ASSTE_TYPES = ['CommonWork', 'Recording', 'Document']
  
  
  
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
    self.nr_recordings  = self.catalog_items.where(catalog_itemable_type: 'Recording').size

  end
  
  # counter cache
  def count_common_works
    self.nr_common_works = common_works.size

  end
  
  # counter cache
  def count_assets
    #puts '-----------------------count_assets ---------------------------------'
    self.nr_assets = self.catalog_items.where(catalog_itemable_type: ['Document', 'Artwork']).size
  end
  
  # counter cache
  def count_users
    self.nr_users = self.catalog_users.where(role: 'Catalog User').size
  end
  
  def recordings
    Recording.where(id: recording_ids)
  end
  
  def recording_ids
    recording_ids = catalog_items.where(catalog_itemable_type: 'Recording').pluck(:catalog_itemable_id)
  end
  
  def common_works
    
    common_work_ids = CatalogItem.where(catalog_id: self.id, catalog_itemable_type: 'CommonWork').pluck(:catalog_itemable_id)
    CommonWork.where(id: common_work_ids)

  end

  # add a batch of recordings to the catalog
  def add_recordings recordings
    recordings.each do |recording|
      add_recording recording
    end
  end
  
  
  # add a recording to the catalog
  # after added also create a catalog item for the common work
  def add_recording recording
    # find or create a new catalog item for the recording
    catalog_item = CatalogItem.where( catalog_itemable_id: recording.id,
                                      catalog_itemable_type: 'Recording',
                                      catalog_id: self.id
                                     )
                              .first_or_create( catalog_itemable_id: recording.id,
                                                catalog_itemable_type: 'Recording',
                                                catalog_id: self.id
                                               )
                                
    add_common_work recording.common_work 
  end
  
  # add a common work to a catalog
  def add_common_work common_work,
    catalog_item = CatalogItem.where( catalog_itemable_id: common_work.id,
                                      catalog_itemable_type: 'CommonWork',
                                      catalog_id: self.id
                                     )
                              .first_or_create( catalog_itemable_id: common_work.id,
                                                catalog_itemable_type: 'CommonWork',
                                                catalog_id: self.id
                                               )
  end
  
  
  
  # fetch all artwork in the catalog
  def artworks
    artwork_ids = CatalogItem.where(catalog_id: self.id, catalog_itemable_type: 'Artwork').pluck(:catalog_itemable_id)
    @artworks = Artwork.order('title asc').where(id: artwork_ids)
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
  
  def remove_account_users
    puts '----------------------------------'
    puts 'remove_account_users'
  end

end
