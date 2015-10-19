class IpiPublisher < ActiveRecord::Base
  belongs_to :ipi
  belongs_to :user
  belongs_to :publisher
  belongs_to :publishing_agreement
  
  validates :email, presence: true
  validates_formatting_of :email, :using => :email
  
  after_commit :flush_cache
  
  before_destroy :reset_common_work_ipis
  
  
  def reset_common_work_ipis
    CommonWorkIpi.where(
      email: self.email, 
      ipi_publisher_id: self.id
    )
    .update_all(
      email: self.email, 
      ipi_publisher_id: nil
    )
    
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def attach_to_user
    if user = User.get_by_email( self.email )
      self.update(
        ipi_id: user.ipi.id,
        user_id: user.id,
        email:   user.email
      )
    end
  end
  
  def attach_to_common_work_ipis
    
    CommonWorkIpi.where(
      email: self.email, 
      ipi_publisher_id: nil
    )
    .update_all(
      email: self.email, 
      ipi_publisher_id: self.id
    )
  end
  
  def title
    return publisher.legal_name if publisher
    'na'  
  end

 

  private 

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
  
end
