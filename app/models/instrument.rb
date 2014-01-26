class Instrument < ActiveRecord::Base
  
  has_many :instrument_tags
  has_many :recordings, through: :instrument_tags
    
  scope :by_users,    -> { where('user_tag IS TRUE') }
  scope :by_digiramp, -> { where('user_tag IS NOT TRUE') }
  validates_uniqueness_of :title
  
  def self.by_comma_seperated string
    instruments = []
    if string
      string.split(",").each do |title|
        title = title.to_s.strip.downcase
        instrument = find :first, :conditions => ["lower(title) = ?", title]
        instrument ||= create! user_tag: true, title: title
        instruments << instrument if instrument
      end
    end
    
    instruments
  end
end
