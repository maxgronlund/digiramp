class UserPublisher < ActiveRecord::Base
  
  validates_formatting_of :email  
    
  belongs_to :user
  belongs_to :publisher
  
  #after_commit :connect_to_publisher
  #
  #def connect_to_publisher
  #  return nil if self.destroyed?
  #  if publisher = Publisher.find_by(email: self.email)
  #    self.update_columns(publisher_id: publisher.id)
  #  end
  #end
end
