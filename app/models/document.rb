class Document < ActiveRecord::Base
  has_paper_trail
  include PgSearch
  pg_search_scope :search_in_documents, against: [:title, :body, :text_content], :using => [:tsearch]
  
  mount_uploader :file, DocumentUploader
  
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
  
  def user
    begin
      return account.user
    rescue
      ErrorNotification.post "Document#user: #{self.id}"
    end
    nil
  end
  
  
  def controller_by
    return user.full_name if user
    ''
  end
  
  def used_on
    
  end
  
  def execute_document
    
  end
  
  def download_url
    
    s3 = Aws::S3::Resource.new
    secure_url = self.file_url
    
    begin
      secure_url.gsub!("https://digiramp.s3.amazonaws.com/", '')
      bucket      = s3.bucket(Rails.application.secrets.aws_s3_bucket)
      s3_obj      =  bucket.object(secure_url)
      filename    = self.title.downcase.gsub(' ', '-') + File.extname(secure_url)
      secure_url  = s3_obj.presigned_url(:get, expires_in: 600,response_content_disposition: "attachment; filename='#{filename}'")
    rescue => e
      ap e.inspect
      secure_url = self.file_url
    end
    secure_url
  end
  
  def uploaded?
    !content_type.nil?
  end
  
  #def self.self_distribution
  #  Document.where(uuid: "38e2814a-45ce-11e5-b8b5-d43d7eecec4d")
  #  .first_or_create(
  #    title: "Self Distribution",
  #    document_type: "Template",
  #    body: "You represent and warrant that you are free to enter into and abide by the \r\nterms of this Agreement and that you are the sole owner of the master recordings embodying the following compositions",
  #    text_content: "DISTRIBUTION AGREEMENT",
  #    tag: "Distribution",
  #    uuid: "38e2814a-45ce-11e5-b8b5-d43d7eecec4d",
  #  )
  #end
  #
  #def self.self_publishing
  #  Document.where(uuid: '5dcab336-5dd6-11e5-88f3-d43d7eecec4d')
  #  .first_or_create(
  #    title: "Self publishing",
  #    document_type: "Template",
  #    body: "Self publishing ( I validate i'm my own rightful publisher )",
  #    text_content: "Self publishing ( I validate i'm my own rightful publisher )",
  #    tag: "Publishing",
  #    uuid: "5dcab336-5dd6-11e5-88f3-d43d7eecec4d",
  #  )
  #end
  #
  #
  #
  #
  #
  #def self.mp3_term_of_usage
  #  Document.where(uuid: "38e2fddc-45ce-11e5-b8b5-d43d7eecec4d")
  #  .first_or_create(
  #    title: "Term of usage for a mp3 file bought in the shop",
  #    document_type: "Template",
  #    body: "You what you can use a mp3 for",
  #    text_content: "MP3 usage agreement",
  #    account_id: 380,
  #    file_size: 0,
  #    tag: "Recording",
  #    uuid: "38e2fddc-45ce-11e5-b8b5-d43d7eecec4d",
  #  )
  #end
  
 
  
private
  
  def flush_cache
    Rails.cache.delete([self.class.name, uuid])
  end
end
