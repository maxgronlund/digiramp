class Blog < ActiveRecord::Base

  
  has_many :blog_posts
  LAYOUTS = %w[layout_3_9 layout_4_8 layout_4_4_4 layout_6_6 layout_8_4 layout_9_3 layout_12 badges3 ]
  validates_presence_of :title


  
  
  def self.cached_find(identity)
    Rails.cache.fetch([name, identity ]) {  Blog.where(identifier: identity)\
                                                .first_or_create(identifier: identity, title: identity, body: '') }
  end
  
  def self.blog_search( query)
    if query.present?
     return Blog.search(query)
    else
      return Blog.all
    end
  end
  

  
private

  def flush_cache
    Rails.cache.delete([self.class.name, identity])
  end
end


# delete '
# Homepage Content
# About Page Content