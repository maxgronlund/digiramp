class Blog < ActiveRecord::Base
  has_paper_trail
  
  has_many :blog_posts
  LAYOUTS = %w[layout_3_9 layout_4_8 layout_4_4_4 layout_6_6 layout_8_4 layout_9_3 layout_12 badges3 ]
  validates_presence_of :title

  after_commit :flush_cache
  
  include PgSearch
  pg_search_scope :search_blog, against: [:title, :body], :using => [:tsearch],  :associated_against => {
    :blog_posts => [:title, :body, :teaser]
  }
  
 

  
  def self.search(  query)
    if query.present?
      return Blog.search_blog(query)
    else
      return all
    end
  end
  

  def self.cached_find(idnf)
    Rails.cache.fetch([name, idnf ]) {  Blog.where(identifier: idnf)
                                            .first_or_create(identifier: idnf, title: idnf, body: '') }
  end 
  
  def self.news_count 
    blog = Blog.cached_find('news blog')
    blog.blog_posts.count
  end
private

  def flush_cache
    Rails.cache.delete([self.class.name, self.identifier])
  end
end


# delete '
# Homepage Content
# About Page Content