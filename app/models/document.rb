class Document < ActiveRecord::Base
  belongs_to :account
  
  TYPES = ['File', 'Financial', 'Legal']

  after_commit :flush_cache

  include PgSearch
  pg_search_scope :search_in_documents, against: [:title, :body, :text_content], :using => [:tsearch]
  
  before_destroy :remove_relations

  def remove_relations
    catalog_items               = CatalogItem.where(catalog_itemable_id: self.id, catalog_itemable_type: self.class.name)
    catalog_items.destroy_all
    
    #playlist_items = PlaylistItem.where(playlist_itemable_id: self.id, playlist_itemable_type: self.class.name)
    #playlist_items.destroy_all
    
  end

  def self.catalogs_search(documents, query)
    if query.present?
     documents = documents.search_in_documents(query)
    end
    documents
  end
  
  
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
