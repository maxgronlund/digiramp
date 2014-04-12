class Attachment < ActiveRecord::Base
  belongs_to :account
  belongs_to :attachable, polymorphic: true
  
  after_commit :flush_cache
  
  mount_uploader :file, DocumentUploader
  
  include PgSearch
  pg_search_scope :search, against: [:title, :file_type ], :using => [:tsearch]
  
  
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  scope :files,               -> { where(file_type: "file") }
  scope :legal_documents,     -> { where(file_type: "legal_document") }
  scope :financial_documents, -> { where(file_type: "financial_document") }
  
  FILE_TYPES = ["file", "legal_document", "financial_document" ]

  def self.account_search(account, query)
    attachments = account.attachments
    if query.present?
     attachments = attachments.search(query)
    end
    attachments
  end
  
private
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
