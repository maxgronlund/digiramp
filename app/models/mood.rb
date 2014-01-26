class Mood < ActiveRecord::Base
  
  has_many :mood_tags
  has_many :recordings, through: :mood_tags
    
  scope :by_users,    -> { where('user_tag IS TRUE') }
  scope :by_digiramp, -> { where('user_tag IS NOT TRUE') }
  validates_uniqueness_of :title
  
  def self.by_comma_seperated string
    moods = []
    
    if string
      string.split(",").each do |title|
        title = title.to_s.strip.downcase
        mood = find :first, :conditions => ["lower(title) = ?", title]
        mood ||= create! user_tag: true, title: title.capitalize
        moods << mood if mood
      end
    end
    
    moods
  end
  
end
