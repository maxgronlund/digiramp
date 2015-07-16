# SetUserTopTag.process user

class AccountDefaultLegalDocuments
  
  
  def self.copy_templates account_id, type, legal_tag
    
    Document.where(account_id: account_id, type: type: legal )
    
  end
  
  
end