class Genre < ActiveRecord::Base
  
  has_many :genre_tags
  has_many :recordings, through: :genre_tags
    
  scope :by_users,    -> { where('user_tag IS TRUE') }
  scope :by_digiramp, -> { where('user_tag IS NOT TRUE') }
  validates_uniqueness_of :title
  
  
  def self.by_comma_seperated string
    genres = []
    if string
      string.to_s.split(",").each do |title|
        title = title.to_s.strip.downcase
        genre = find :first, :conditions => ["lower(title) = ?", title]
        genre ||= create! user_tag: true, title: title
        genres << genre if genre
      end
    end
    
    genres
  end

end
