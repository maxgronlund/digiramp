class Gallery < ActiveRecord::Base

  has_many :artworks
  
  def self.home 
    find_or_create_by_title('home')
  end
  
end
