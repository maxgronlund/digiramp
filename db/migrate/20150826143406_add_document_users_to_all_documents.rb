class AddDocumentUsersToAllDocuments < ActiveRecord::Migration
  def change
    
    Document.find_each do |document|
      if account = document.account
        if user = account.user
           DocumentUser.where(user_id: user.id, 
                              document_id: document.uuid)
             .first_or_create(user_id: user.id, 
                              document_id: document.uuid,
                              can_edit: true,
                              email: user.email,
                              status: 1)
             
             
        end
      end
    end
  end
end
