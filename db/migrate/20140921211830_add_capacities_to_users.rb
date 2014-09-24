class AddCapacitiesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fan, :boolean           , default: false
    add_column :users, :writer, :boolean        , default: false
    add_column :users, :author, :boolean        , default: false
    add_column :users, :producer, :boolean      , default: false
    add_column :users, :composer, :boolean      , default: false
    add_column :users, :remixer, :boolean       , default: false
    add_column :users, :musician, :boolean      , default: false
    add_column :users, :dj, :boolean            , default: false
    add_column :users, :location, :string, default: ''
  end
end
