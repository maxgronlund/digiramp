class VideoBlog < ActiveRecord::Base
  has_many :videos
  #attr_accessible :title, :body
  validates :title, uniqueness: true
  
  include PgSearch
  pg_search_scope :search, against: [ :title, 
                                      :body, 
                                      ], :using => [:tsearch]
                                    
                                    
  
  
  def self.blog_search( query)
    if query.present?
     return VideoBlog.search(query)
    else
      return VideoBlog.all
    end
  end
  
  

  def self.cached_find(identifier)
    Rails.cache.fetch([name, identifier ]) {  VideoBlog.where(identifier: identifier)\
                                                .first_or_create(identifier: identity, title: identifier, body: '') }
  end 
private

  def flush_cache
    Rails.cache.delete([self.class.name, self.identifier])
  end
end
