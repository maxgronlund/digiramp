class DocumentExtractTextWorker
  include Sidekiq::Worker
  
  def perform( document_id )
    document              = Document.cached_find(document_id)
    yomu                  = Yomu.new document.file
    document.text_content =  yomu.text
    document.save!
  end
end