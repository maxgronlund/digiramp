class Genre < ActiveRecord::Base
  
  #has_many :genre_tags
  #has_many :recordings, through: :genre_tags
  
  include PgSearch
  pg_search_scope :search_genre, against: [:title, :category], :using => [:tsearch]
  
  GENRE_CATEGORY = {popular_music: "Popular Music", cinematic: "Cinematic", classical: "Classical", ethnic_world: "Ethnic World", jazz: "Jazz", other: "Other"}
  
  
  scope :popular_music, -> { where(category: 'popular_music')}
  scope :cinematic,     -> { where(category: 'cinematic')}
  scope :classical,     -> { where(category: 'classical')}
  scope :ethnic_world,  -> { where(category: 'ethnic_world')}
  scope :jazz,          -> { where(category: 'jazz')}
  scope :other,         -> { where(category: 'other')}
    
  scope :by_users,    -> { where('user_tag IS TRUE') }
  scope :by_digiramp, -> { where('user_tag IS NOT TRUE') }
  validates_uniqueness_of :title
  after_commit :flush_cache
  
  #def self.by_comma_seperated string
  #  genres = []
  #  if string
  #    string.to_s.split(",").each do |title|
  #      title = title.to_s.strip.downcase
  #      genre = find :first, :conditions => ["lower(title) = ?", title]
  #      genre ||= create! user_tag: true, title: title
  #      genres << genre if genre
  #    end
  #  end
  #  
  #  genres
  #end
  
  def category_name
    self.category.gsub('_', ' ').capitalize
  end
  
  def self.search( query)
    if query.present?
      return Genre.search_genre(query)
    else
      return all
    end
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
private
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

end
