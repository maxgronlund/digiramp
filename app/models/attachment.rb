class Attachment < ActiveRecord::Base
  belongs_to :account_file
  belongs_to :attachable, polymorphic: true
  
  after_commit :flush_cache
  
  mount_uploader :file, DocumentUploader
  
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  scope :files,               -> { where(file_type: "file") }
  scope :legal_documents,     -> { where(file_type: "legal_document") }
  scope :financial_documents, -> { where(file_type: "financial_document") }
  
  FILE_TYPES = ["file", "legal_document", "financial_document" ]

  
private
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
