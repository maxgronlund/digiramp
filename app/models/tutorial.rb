class Tutorial < ActiveRecord::Base
  
  mount_uploader :thumbnail, TutorialUploader
  
  def self.introduction
    Tutorial.where(identifier: 'introduction').first_or_create(identifier: 'introduction', title: 'Introduction to DigiRAMP')
  end
  
  def self.introduction_to_pages
    Tutorial.where(identifier: 'introduction_to_pages').first_or_create(identifier: 'introduction_to_pages', title: 'Introduction to pages')
  end
end
