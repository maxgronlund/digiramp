class Genre < ActiveRecord::Base
  
  #has_many :genre_tags
  #has_many :recordings, through: :genre_tags
  
  include PgSearch
  pg_search_scope :search_genre, against: [:title, :category], :using => [:tsearch]
  
  GENRE_CATEGORY = ["Popular Music", "Cinematic", "Classical", "Ethnic World", "Jazz", "Other"]
  
  
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
  
  def self.to_csv
    CSV.generate do |csv|
      csv << ['Id','Category', 'Genre', 'INgrooves Category', 'INgrooves Genre', 'iTunes Category', 'iTunes Genre', 'User Genre' ]
    
      all.each do |genre|
        csv << [  genre.id.to_s, 
                  genre.category, 
                  genre.title, 
                  genre.ingrooves_category, 
                  genre.ingrooves_genre, 
                  genre.itunes_category, 
                  genre.itunes_genre,
                  genre.user_tag
                ]
      end

    end
  end
  
  def self.import_csv(csv_file)
    CSV.foreach(csv_file.path, headers: true) do |row|
      genre_row   = row.to_hash
      begin
        genre_id    = genre_row["Id"].to_i 
        genre_title = genre_row["Genre"].to_s.titleize 
        
        if Genre.exists?( genre_id  )
          @genre  = Genre.cached_find( genre_id )
          
        else             
          @genre  = Genre.where( title: genre_title ).first_or_create( title: genre_title )
        end
          
        import_category            = genre_row["Category"].to_s == '' ? 'Other' : genre_row["Category"].to_s 
        @genre.title               = @genre.title.titleize  
        @genre.category            = import_category.strip.gsub('_',' ').titleize                              
        @genre.ingrooves_category  = genre_row["INgrooves Category"].to_s                    
        @genre.ingrooves_genre     = genre_row["INgrooves Genre"].to_s                
        @genre.itunes_category     = genre_row["iTunes Category"].to_s                    
        @genre.itunes_genre        = genre_row["iTunes Genre"].to_s        
        @genre.user_tag            = genre_row["User Genre"].to_s == 'true'
      
        @genre.save
      rescue
        @genre.destroy
      end
    end
  end
  
  
  
private
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

end
