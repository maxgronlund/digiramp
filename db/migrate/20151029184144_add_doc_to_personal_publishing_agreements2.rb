class AddDocToPersonalPublishingAgreements2 < ActiveRecord::Migration
  def change
    missing_document_users = 0
    missing_documents = 0
    User.find_each do |user|
      if user.personal_publishing_agreement_document_user
      else
        missing_document_users += 1
        create_document_user user
        if user.personal_publishing_agreement_document
        else
          missing_documents += 1
        end
      end
    end
    ap '========================================================'
    ap "Missing document_users: #{missing_document_users}"
    ap "Missing documents: #{missing_documents}"
    ap '========================================================'
  end
  
  def create_document_user user
    
    DocumentUser.create(
      document_id: user.personal_publishing_agreement_document.uuid,
      user_id: user.id,
      account_id: user.account_id,
      can_edit: true,
      should_sign: true,
      email: user.email,
      role: "Publisher",
      legal_name: user.get_full_name,
      ok: false
    )
    
  end
  
end
