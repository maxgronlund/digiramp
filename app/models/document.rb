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
  
  #def self.clone_templates account_id, tag, document_type
  #  documents = []
  #  Document.where(tag: 'Recording', document_type: 'Template').each do |template|
  #    document = Document.create( title:          template.title, 
  #                                body:           template.body, 
  #                                text_content:   template.text_content,
  #                                tag:            tag,
  #                                document_type:  document_type,
  #                                account_id:     account_id,
  #                                template_id:    template.id).id
  #                                  
  #    
  #    DigitalSignature.clone_signatures_from template, document
  #    documents << document
  #  end
  #  documents
  #end

  
  #Document.clone_templates(
  #
  #
  #)
  

  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find_by(uuid: id) }
  end
  
  def digital_signatures
    DigitalSignature.where(signable_type: self.class.name, signable_id: self.id)
  end
  
  def signed?
    self.document_users.each do |document_user|
      return false if( document_user.should_sign && document_user.digital_signature_id.nil?)
    end
    true
  end
  
  def used_on
    
  end
  
  def execute_document
    
  end
  
  #def publishing_agreement
  #  return nil unless self.document_type == 'Publishing agreement'
  #  PublishingAgreement.find_by(document_id: self.uuid)
  #end
  
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
    Rails.cache.delete([self.class.name, uuid])
  end
end
