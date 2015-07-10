class Document < ActiveRecord::Base
  
  validates :title, :body, :text_content, presence: true
  
  belongs_to :account
  has_and_belongs_to_many :catalogs
  
  has_many :document_users
  
  TYPES = ['File', 'Financial', 'Legal', 'Template']
  
  scope :files,           ->  { where( document_type: 'File')  }
  scope :financial,       ->  { where( document_type: 'Financial')  }
  scope :templates,       ->  { where( document_type: 'Template')  }
  scope :legal,           ->  { where( document_type: 'Legal')  }
  scope :csv,             ->  { where( document_type: 'Csv')  }
  
  

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
  
  def digital_signatures
    DigitalSignature.where(signable_type: self.class.name, signable_id: self.id)
  end
  
  #def copy_signatures_from_template
  #  if self.template_id 
  #    if template = Document.find_by(id: self.template_id)
  #      
  #      template.sigital_signatures.each do |digital_signature|
  #        signature = DigitalSignature.new( signable_id: self.id,
  #                                          signable_type: self.class.name,
  #                                          role: digital_signature.role
  #                                          )
  #        signature.save(validate: false)
  #      end
  #      
  #    end
  #  end
  #end
  
private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
