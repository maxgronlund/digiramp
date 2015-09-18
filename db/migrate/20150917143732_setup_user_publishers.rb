class SetupUserPublishers < ActiveRecord::Migration
  def up
    #PgSearch::Multisearch.rebuild(Document)
    Document.where(
        title:          'Personal publishing',
        document_type:  "Personal Publishing",
        uuid:           "8f82c102-5d40-11e5-b9bb-60334bfffe81"
      ).first_or_create(
        title:          'Personal publishing',
        document_type: "Personal Publishing",
        uuid:           "8f82c102-5d40-11e5-b9bb-60334bfffe81",
        body:           "na",
        text_content:   "text_content"
      )
      
      
    Publisher.destroy_all
    PublishingAgreement.destroy_all
    
    User.find_each do |user|
      user.setup_personal_publishing
    end
    
  end
  
  def down
    
  end
end
