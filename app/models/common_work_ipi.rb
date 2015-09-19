class CommonWorkIpi < ActiveRecord::Base
  belongs_to :common_work
  belongs_to :ipi
  belongs_to :publishing_agreement
  
  validates_presence_of :email
  validates_formatting_of :email, :using => :email
  
  enum status: [ :pending, :accepted, :dismissed, :in_progress ]
  
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  def attach_to_ip
    
    return if self.ipi
    
    if user = User.find_by(email: self.email)
      if _ipi = user.ipi
        self.update(ipi_id: _ipi.id)
        self.accepted!
      end
    end
  end
  
  private 

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
    
    
  
end
