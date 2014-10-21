class Mood < ActiveRecord::Base
  
  has_many :mood_tags, dependent: :destroy
  has_many :recordings, through: :mood_tags
    
  scope :by_users,    -> { where('user_tag IS TRUE') }
  scope :by_digiramp, -> { where('user_tag IS NOT TRUE') }
  
  validates_uniqueness_of :title
  after_commit :flush_cache
  
  MOOD_CLASSIFICATION = [  "Energized Pleasant", 
                           "Energized Unpleasant", 
                           "Calm Pleasant", 
                           "Calm Unpleasant"
                        ]
  
  scope :energized_pleasant,   -> { where(category: 'Energized Pleasant')}
  scope :energized_unpleasant, -> { where(category: 'Energized Unpleasant')}
  scope :calm_pleasant,        -> { where(category: 'Calm Pleasant')}
  scope :calm_unpleasant,      -> { where(category: 'Calm Unpleasant')}
  scope :other,                -> { where(category: 'Other')}
  scope :user_moods,           -> { where(category: 'User Mood')}
  scope :user_tags,            -> { where(user_tag: true)}
                     
  #before_destroy :delete_mood_tags
  
  include PgSearch
  pg_search_scope :search_moods, against: [:title, :category], :using => [:tsearch]
  
  #def delete_mood_tags
  #  mood_tags.delete_all
  #end
  
  def self.search( query)
    if query.present?
      return Mood.search_moods(query)
    else
      return all
    end
  end
  
  def recordings
    recording_ids = self.mood_tags.where(mood_tagable_type: 'Recording').pluck(:mood_tagable_id)
    Recording.where(id: recording_ids)
  end
  
  
  
  def self.to_csv
    CSV.generate do |csv|
      csv << ['Id','Category', 'Mood','User Tag', 'Delete' ]
    
      all.each do |mood|
        
        csv << [  mood.id.to_s, 
                  mood.category, 
                  mood.title.titleize , 
                  mood.user_tag,
                  ''
                ]
      end
    
    end
  end
  
  def self.import_csv(csv_file)
    CSV.foreach(csv_file.path, headers: true) do |row|
      mood_row   = row.to_hash
      begin
        mood_id       = mood_row["Id"].to_i 
        mood_category = mood_row["Category"].to_s == '' ? 'Other' : mood_row["Category"].to_s 
        mood_title    = mood_row["Mood"].to_s

        if Mood.exists?( mood_id  )
          @mood  = Mood.find( mood_id )
        else             
          @mood  = Mood.where( title: mood_title ).first_or_create( title: mood_title )
        end
        
        @mood.category       = mood_category.strip.gsub('_',' ').titleize
        @mood.title          = mood_title.titleize 
        @mood.user_tag       = mood_row["User Tag"].to_s == 'true'
        
        mood_row["Delete"].to_s != '' ? @mood.destroy : @mood.save!
      rescue
        logger.debug '------------------------------ RESCUED ---------------------------------'
        @mood.destroy if @mood
      end
    end
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def reset_count
    self.recordings_count = self.recordings.count
    save
  end
  
private
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  
  #def self.by_comma_seperated string
  #  moods = []
  #  
  #  if string
  #    string.split(",").each do |title|
  #      title = title.to_s.strip.downcase
  #      mood = find :first, :conditions => ["lower(title) = ?", title]
  #      mood ||= create! user_tag: true, title: title.capitalize
  #      moods << mood if mood
  #    end
  #  end
  #  
  #  moods
  #end
  
end
