class UpdatePersonalPublishingDocuments < ActiveRecord::Migration
  def change

    #User.find_each do |user|
    #  update_document_users user
    #  
    #  if personal_publishing_agreement = user.personal_publishing_agreement
    #    if document = personal_publishing_agreement.document
    #      if document.document_users.empty?
    #        document_user = DocumentUser.where(
    #          user_id: user.id,
    #          role:     "Publisher"
    #        )
    #        .first_or_create(
    #          user_id:            user.id,
    #          role:               "Publisher",
    #          
    #        )
    #        document_user.update(
    #          document_id:        document.uuid,
    #          account_id:         user.account_id,
    #          can_edit:           true,
    #          should_sign:        true,
    #          email:              user.email,
    #          legal_name:         user.get_full_name
    #        )
    #        document_user.pending!
    #      else
    #        if document_user = document.document_users.first
    #          document_user.update(
    #            account_id:         user.account_id,
    #            can_edit:           true,
    #            should_sign:        true,
    #            email:              user.email,
    #            legal_name:         user.get_full_name
    #          )
    #          document_user.pending!
    #          
    #        end
    #      end
    #    end
    #  end
    #end
  end
  
  def update_document_users user
  
    user.document_users.each do |document_user|
      if document_user.document.nil?
        document_user.destroy
      else
        document_user.update(
          account_id: document_user.user.account_id
        )
      end
    end
  end
end
