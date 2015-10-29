class UpdateContentInSelfPublishingDocuments < ActiveRecord::Migration
  def change
    template = Document.find_by(uuid: '5dcab336-5dd6-11e5-88f3-d43d7eecec4d')
    User.find_each do |user|
      if personal_publishing_agreement = user.personal_publishing_agreement
        if document = personal_publishing_agreement.document
          document.update_columns(text_content: template.text_content)
          Rails.cache.delete([document.class.name, document.uuid])
        else
          ap '<<<<<<<<<< document not found >>>>>>>>>>>>>>>>>>>>>'
          
          
        end
      
      else
        ap '<<<<<<<<<< personal_publishing_agreement not found >>>>>>>>>>>>>>>>>>>>>'
      end
    end
  end
end
