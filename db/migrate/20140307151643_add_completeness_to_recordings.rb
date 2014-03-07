class AddCompletenessToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :has_title, :boolean
    add_column :recordings, :has_lyrics, :boolean
    add_column :recordings, :completeness_in_pct, :integer
    add_column :recordings, :category, :string
    add_column :recordings, :mp3, :string
  end
end
