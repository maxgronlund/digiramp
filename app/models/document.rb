class Document < ActiveRecord::Base
  has_paper_trail
  include PgSearch
  pg_search_scope :search_in_documents, against: [:title, :body, :text_content], :using => [:tsearch]
  
  validates :title, :body, :text_content, :uuid, presence: true
  
  belongs_to :account
  has_and_belongs_to_many :catalogs
  
  has_many :document_users, primary_key: :uuid
  has_many :digital_signatures
  has_many :digital_signatures,        as: :signable,     dependent: :destroy
  
  
  TYPES = ['File', 'Financial', 'Legal', 'Template']

  
  scope :files,                   ->  { where( document_type: 'File')  }
  scope :financial,               ->  { where( document_type: 'Financial')  }
  scope :templates,               ->  { where( document_type: 'Template')  }
  scope :legal,                   ->  { where( document_type: 'Legal')  }
  scope :csv,                     ->  { where( document_type: 'Csv')  }
  scope :publishing_agreements,   ->  { where( document_type: 'Publishing agreement')  }
  
  enum status: [ :draft, :execution_copy, :executed, :deleted, :archived, :expired ]
  

  after_commit :flush_cache

  # !!! name
  def self.catalogs_search(documents, query)
    if query.present?
     documents = documents.search_in_documents(query)
    end
    documents
  end
  
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find_by(uuid: id) }
  end
  
  def digital_signatures
    DigitalSignature.where(signable_type: self.class.name, signable_id: self.id)
  end
  
  def signed?
    return false if self.document_users.count == 0
    self.document_users.each do |document_user|
      return false if( document_user.should_sign && document_user.digital_signature_id.nil?)
    end
    true
  end
  
  def used_on
    
  end
  
  def execute_document
    
  end
  
 
  
private
  
  def flush_cache
    Rails.cache.delete([self.class.name, uuid])
  end
end
