class UniqifyTitlesOnRecordings < ActiveRecord::Migration
  def change
    Recording.find_each do |recording|
      if recording.uniq_title.blank?
        recording.uniq_title = recording.title.to_uniq
        recording.save!
      end
    end
  end
end
