class CommonWorkItem < ActiveRecord::Base
  

  
  belongs_to :common_work
  belongs_to :attachable, polymorphic: true
  
  
end
