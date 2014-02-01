class Home < ActiveRecord::Base
  
  def self.front; Home.where(id: 1).first_or_create() end
end
