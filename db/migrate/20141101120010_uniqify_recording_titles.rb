class UniqifyRecordingTitles < ActiveRecord::Migration
  def change
    add_column :recordings, :uniq_title, :string, default: ''
    Recording.find_each do |recording|
      recording.uniq_title = recording.title.to_uniq
      recording.save!
    end
  end
end
