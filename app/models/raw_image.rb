class RawImage < ActiveRecord::Base
  mount_uploader :image,   ImageUploader
  
  validates_presence_of :title
  validates_presence_of :identifier
  #validates_presence_of :image
  
  def self.banner_example 
    where(identifier: 'banner_example').first_or_create(identifier: 'banner_example', title: 'Banner example') 
  end
  
  def self.recording_example 
    where(identifier: 'recording_example').first_or_create(identifier: 'recording_example', title: 'Recording example')
  end
  
  def self.playlist_example 
    where(identifier: 'playlist_example').first_or_create(identifier: 'playlist_example', title: 'Playlist example')
  end
  
  def self.horizontal_links_example
    where(identifier: 'horizontal_links_example').first_or_create(identifier: 'horizontal_links_example', title: 'Horizontal links example')
  end
  
  def self.vertical_links_example
    where(identifier: 'vertical_links_example').first_or_create(identifier: 'vertical_links_example', title: 'Vertical links example')
  end
  
  def self.playlist_link_example
    where(identifier: 'playlist_link_example').first_or_create(identifier: 'playlist_link_example', title: 'Playlist link example')
  end
  
  def self.video_snippet_example
    where(identifier: 'video_snippet_example').first_or_create(identifier: 'video_snippet_example', title: 'Video snippet example')
  end
  
  def self.text_example
    where(identifier: 'text_example').first_or_create(identifier: 'text_example', title: 'Text example')
  end
  
  def self.comment_example
    where(identifier: 'comment_example').first_or_create(identifier: 'comment_example', title: 'Comment example')
  end
  
end
