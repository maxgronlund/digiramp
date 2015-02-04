class ClientImport < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  has_many :clients
  
  mount_uploader :file , CsvUploader
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def invite_clients

    case self.source
      
    when 'linkedin'
      ClientInvitationMailer.delay.import_form_linkedin( self.id )
    end
  end

private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
end
