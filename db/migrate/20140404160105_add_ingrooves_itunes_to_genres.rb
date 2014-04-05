class AddIngroovesItunesToGenres < ActiveRecord::Migration
  def change
    add_column :genres, :ingrooves_category, :string , default: ''
    add_column :genres, :ingrooves_genre, :string    , default: ''
    add_column :genres, :itunes_category, :string    , default: ''
    add_column :genres, :itunes_genre, :string       , default: ''
  end
end
