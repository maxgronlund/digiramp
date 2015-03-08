class Document < ActiveRecord::Base
  belongs_to :account
  has_and_belongs_to_many :catalogs
  
  TYPES = ['File', 'Financial', 'Legal']
  
  scope :files,     ->  { where( document_type: 'File')  }
  scope :financial, ->  { where( document_type: 'Financial')  }
  scope :legal,     ->  { where( document_type: 'Legal')  }
  scope :csv,       ->  { where( document_type: 'Csv')  }

  after_commit :flush_cache

  include PgSearch
  pg_search_scope :search_in_documents, against: [:title, :body, :text_content], :using => [:tsearch]
  
 

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
