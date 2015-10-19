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
  has_many :digital_signatures,        as: :signable,        dependent: :destroy
  
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
  
  def error_message
    em = {}
    document_users.each do |document_user|
      unless document_user.do_validation
        em["document_user_#{document_user_id}"] = document_user.error_message
      end
    end
    
    if self.body.blank?
      em[:content] = "Document is blank"
    end
    em
    
  end
  # check if the document is ok
  # save state
  def update_validation 
    ap 'document # update_validation'
    set_ok
    p = parent
    parent.update_validation if p
  end
  
  
  def do_validation 
    
    return true if self.ok
    set_ok
    self.ok
  end

  
private

  def set_ok
    #test_for_ok = true
    #test_for_ok = false if self.body.blank?
    
    
    update_columns( ok: error_message.empty? ) 
    
  end

  def parent
    begin
      case self.belongs_to_type
        
      when 'PublishingAgreement'
        return PublishingAgreement.cached_find(self.belongs_to_id)
      end
    rescue => e
      ErrorNotification.post "Document#update_parent: #{e}"
    end
  end
 
  
  def flush_cache
    update_validation
    Rails.cache.delete([self.class.name, uuid])
  end
end
