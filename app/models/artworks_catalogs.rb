class ArtworksCatalogs < ActiveRecord::Base
  belongs_to :artworks
  belongs_to :catalogs
end
