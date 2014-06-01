class Catalog< ActiveRecord::Base
  
  belongs_to :account
  has_many :catalog_items, dependent: :destroy
  has_many :catalog_users, dependent: :destroy
  #belongs_to :catalog_itemable, polymorphic: true
  #attr_accessible :catalog_itemable_type, :catalog_itemable_id, :account_catalog_id
  
  after_commit :flush_cache
  after_create :add_account_users_to_catalog
  before_destroy :remove_account_users
  

  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def nr_recordings
    catalog_items.where(catalog_itemable_type: 'Recording').size
  end
  
  def recordings
    recording_ids = catalog_items.where(catalog_itemable_type: 'Recording').pluck(:catalog_itemable_id)
    Recording.where(id: recording_ids)
  end
  
  def common_works
    # all recordings in the catalog
    recording_ids = catalog_items.where(catalog_itemable_type: 'Recording').pluck(:catalog_itemable_id)
    # work ids from all the recordings
    work_ids = Recording.where(id: recording_ids).pluck(:common_work_id)
    # remove dublets
    work_ids.uniq
    # fetch the common works
    CommonWork.where(id: work_ids)
    
  end
  
  def add_account_users_to_catalog
    # migration hack feel fre to remove the line belove
    if self.account
      # keep this
      self.account.account_users.each do |account_user|
        add_account_user account_user
      end
    end
  end
  
  def add_account_user account_user

    catalog_user = CatalogUser.create(  user_id: account_user.user_id, 
                                        catalog_id: self.id,
                                        account_id: account_user.account_id,
                                        role: 'Account User')
    
    # copy permissions to catalog user                                    
    Permissions::TYPES.each do |permission|
      eval "catalog_user.#{permission} = account_user.#{permission}"
    end
    catalog_user.save!
  end
  
private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  def remove_account_users
    puts '----------------------------------'
    puts 'remove_account_users'
  end

end
