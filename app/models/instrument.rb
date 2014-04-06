class Instrument < ActiveRecord::Base
  
  has_many :instrument_tags
  has_many :recordings, through: :instrument_tags
    
  #scope :by_users,    -> { where('user_tag IS TRUE') }
  #scope :by_digiramp, -> { where('user_tag IS NOT TRUE') }
  validates_uniqueness_of :title
  
  
  INSTRUMENT_CLASSIFICATION = [  "Reed", 
                                 "Woodwinds", 
                                 "Brass", 
                                 "Flutes",
                                 "Electronic",
                                 "Keyboards",
                                 "Stringed",
                                 "Percussion",
                                 "Vocal",
                                 "Other"
                              ]
  
  
  before_destroy :delete_instrument_tags
  
  include PgSearch
  pg_search_scope :search_instruments, against: [:title, :category], :using => [:tsearch]
  
  
  scope :reed,          -> { where(category: 'Reed')}
  scope :woodwinds,     -> { where(category: 'Woodwinds')}
  scope :brass,         -> { where(category: 'Brass')}
  scope :flutes,        -> { where(category: 'Flutes')}
  scope :electronic,    -> { where(category: 'Electronic')}
  scope :keyboards,     -> { where(category: 'Keyboards')}
  scope :stringed,      -> { where(category: 'Stringed')}
  scope :percussion,    -> { where(category: 'Percussion')}
  scope :other,         -> { where(category: 'Other')}
  scope :user_tags,     -> { where(user_tag: true) }

  
  validates_uniqueness_of :title
  after_commit :flush_cache
  
  
  def delete_instrument_tags
    instrument_tags.delete_all
  end
  
  
  
  def self.search( query)
    if query.present?
      return Instrument.search_instruments(query)
    else
      return all
    end
  end
  #def self.by_comma_seperated string
  #  instruments = []
  #  if string
  #    string.split(",").each do |title|
  #      title = title.to_s.strip.downcase
  #      instrument = find :first, :conditions => ["lower(title) = ?", title]
  #      instrument ||= create! user_tag: true, title: title
  #      instruments << instrument if instrument
  #    end
  #  end
  #  
  #  instruments
  #end
  
  
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def self.to_csv
    CSV.generate do |csv|
      csv << ['Id','Category', 'Instrument','User Tag', 'Delete' ]
    
      all.each do |instrument|
        csv << [  instrument.id.to_s, 
                  instrument.category, 
                  instrument.title, 
                  instrument.user_tag,
                  ''
                ]
      end
    
    end
  end
  
  def self.import_csv(csv_file)
    CSV.foreach(csv_file.path, headers: true) do |row|
      instrument_row   = row.to_hash
      begin
        instrument_id    = instrument_row["Id"].to_i 
        instrument_title = instrument_row["Instrument"].to_s.titleize 
        
        if Instrument.exists?( instrument_id  )
          @instrument  = Instrument.cached_find( instrument_id )
        else             
          @instrument  = Instrument.where( title: instrument_title ).first_or_create( title: instrument_title )
        end
          
        import_category            = instrument_row["Category"].to_s == '' ? 'Other' : instrument_row["Category"].to_s 
        @instrument.title          = @instrument.title.titleize  
        @instrument.category       = import_category.strip.gsub('_',' ').titleize                              
        @instrument.user_tag       = instrument_row["User Tag"].to_s == 'true'
        @instrument.save
        if instrument_row["Delete"].to_s != ''
          @instrument.destroy
        end
      rescue
        @instrument.destroy
      end
    end
  end
  
  
  
private
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
