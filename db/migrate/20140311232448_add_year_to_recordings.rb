class AddYearToRecordings < ActiveRecord::Migration
  def change
    remove_column :recordings, :duration, :date
    remove_column :recordings, :year
    add_column :recordings, :year,            :string, default: 1001
    add_column :recordings, :duration,        :decimal, default: 0.0
    add_column :recordings, :album_name,      :text, default: ''
    add_column :recordings, :genre,           :text, default: ''
    add_column :recordings, :artist,          :text, default: ''
    add_column :recordings, :comment,         :text, default: ''
    add_column :recordings, :performer,       :text, default: ''
    add_column :recordings, :band,            :string, default: ''
    add_column :recordings, :disc,            :string, default: ''
    add_column :recordings, :track,           :string, default: ''
  end
end
