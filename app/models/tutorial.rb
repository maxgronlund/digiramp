class Tutorial < ActiveRecord::Base
  
  def self.introduction
    Tutorial.where(identifier: 'introduction').first_or_create(identifier: 'introduction', title: 'Introduction to DigiRAMP')
  end
end
