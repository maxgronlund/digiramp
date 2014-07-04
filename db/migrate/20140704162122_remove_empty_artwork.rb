class RemoveEmptyArtwork < ActiveRecord::Migration
  def up
    change_column_default :artworks, :file, ''

    Artwork.all.each do |artwork|
      artwork.destroy if artwork.file.to_s == ''
    end

  end
  
  def down
    
  end
end
