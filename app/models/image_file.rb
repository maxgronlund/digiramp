class ImageFile < ActiveRecord::Base
  belongs_to :account
  belongs_to :recording
  
  #serialize :keywords, Array 
end
