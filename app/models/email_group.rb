class EmailGroup < ActiveRecord::Base
  
  has_many :digiramp_emails, dependent: :destroy
  
  
  
end
