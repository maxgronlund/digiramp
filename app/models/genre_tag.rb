class GenreTag < ActiveRecord::Base
  belongs_to :recording
  belongs_to :genre
  belongs_to :genre_tagable, polymorphic: true
end
