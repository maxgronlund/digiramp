class Genre < ActiveRecord::Base
  
  has_many :genre_tags, dependent: :destroy
  has_many :recordings, through: :genre_tags
  
  #before_destroy :delete_genre_tags
  
  include PgSearch
  pg_search_scope :search_genre, against: [:title, :category], :using => [:tsearch]
  
  GENRE_CATEGORY = ["Popular Music", "Cinematic", "Classical", "Ethnic World", "Jazz", "Other"]
  ITUNES_CATEGORY = [
                      "Blues",
                      "Comedy",
                      "Classical",
                      "Country",
                      "Electronic",
                      "Holiday",
                      "Opera",
                      "Jazz",
                      "Latino",
                      "New Age",
                      "Pop",
                      "R&B/Soul",
                      "Soundtrack",
                      "Dance",
                      "Hip-Hop/Rap",
                      "World",
                      "Alternative",
                      "Rock",
                      "Christian & Gospel",
                      "Vocal",
                      "Easy Listening",
                      "J-Pop",
                      "Enka",
                      "Anime",
                      "Kayokyoku",
                      "Fitness & Workout",
                      "K-Pop",
                      "Karaoke",
                      "Instrumental",
                      "Brazilian"]
                      
                      
                      
  INGROOVES_CATEGORY =   [
                        "Adult Contemporary",
                        "Audio Books",
                        "Blues", 
                        "Children's Music", 
                        "Christian", 
                        "Classical", 
                        "Comedy", 
                        "Country", 
                        "Easy Listening",
                        "Educational",
                        "Electronic",
                        "Folk",
                        "Industrial",
                        "Jazz",
                        "Latin",
                        "Oldies",
                        "Pop",
                        "R&B/Soul",
                        "Rap/Hip-Hop",
                        "Reggae",
                        "Rock",
                        "Soundtrack",
                        "Spoken Word",
                        "World"
                      ]
  
  
  scope :popular_music, -> { where(category: 'Popular Music')}
  scope :cinematic,     -> { where(category: 'Cinematic')}
  scope :classical,     -> { where(category: 'Classical')}
  scope :ethnic_world,  -> { where(category: 'Ethnic World')}
  scope :jazz,          -> { where(category: 'Jazz')}
  scope :other,         -> { where(category: 'Other')}
  scope :user_tags,     -> { where(user_tag: true)}
  
  
  def recordings
    recording_ids = self.genre_tags.where(genre_tagable_type: 'Recording').pluck(:genre_tagable_id)
    Recording.where(id: recording_ids)
  end
  
  def ordered_recordings order
    recording_ids = self.genre_tags.where(genre_tagable_type: 'Recording').pluck(:genre_tagable_id)
    Recording.order(order).where(id: recording_ids)
  end
  
  def ordered_recordings_with_public_access order
    recording_ids = self.genre_tags.where(genre_tagable_type: 'Recording').pluck(:genre_tagable_id)
    Recording.public_access.order(order).where(id: recording_ids, privacy: 'Anyone')
  end
    
  #scope :by_users,    -> { where('user_tag IS TRUE') }
  #scope :by_digiramp, -> { where('user_tag IS NOT TRUE') }
  
  validates_uniqueness_of :title
  after_commit :flush_cache
  
  #def delete_genre_tags
  #  genre_tags.delete_all
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
      csv << ['Id','Category', 'Genre', 'INgrooves Category', 'INgrooves Genre', 'iTunes Category', 'iTunes Genre', 'User Genre', 'Delete' ]
    
      all.each do |genre|
        csv << [  genre.id.to_s, 
                  genre.category, 
                  genre.title, 
                  genre.ingrooves_category, 
                  genre.ingrooves_genre, 
                  genre.itunes_category, 
                  genre.itunes_genre,
                  genre.user_tag,
                  ''
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
  
  def reset_count
    self.recordings_count = self.recordings.count
    save
  end
  
  
  
private
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

end
