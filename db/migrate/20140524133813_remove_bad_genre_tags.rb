class RemoveBadGenreTags < ActiveRecord::Migration
  def change
    GenreTag.all.each do |genre_tag|
      genre_tag.destroy! if genre_tag.genre.nil?
    end
  end
end
