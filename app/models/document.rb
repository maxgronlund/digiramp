class Document < ActiveRecord::Base
  #attr_accessible :document, :title, :body, :account_id, :documentable_id, :documentable_type
  
  
  has_many :activity_events, as: :activity_eventable
  
  belongs_to :account, counter_cache: true
  belongs_to :documentable, polymorphic: true
  
  mount_uploader :document, DocumentUploader
  
  
  before_save :update_document_attributes
  
  #after_create :count_counter_cach_up
  #before_destroy :count_counter_cach_down

private
  
  def update_document_attributes
    if document.present? && document_changed?
      self.content_type = document.file.content_type
      self.file_size = document.file.size
    end
  end
  

  
  #def count_counter_cach_up
  #  case self.documentable_type
  #    
  #  when 'Recording'
  #    recording = Recording.find(self.documentable_id)
  #    recording.documents_count = recording.documents.size
  #    recording.save
  #  end
  #end
  #
  #def count_counter_cach_down
  #  case self.documentable_type
  #    
  #  when 'Recording'
  #    recording = Recording.find(self.documentable_id)
  #    recording.documents_count = recording.documents.size-1
  #    recording.save
  #  end
  #end
  
    
    
end
