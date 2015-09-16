class ActivateLabelsWithRecordings < ActiveRecord::Migration
  def change
    
    Label.find_each do |label|
      label.update(activated: (label.recordings.count > 0 && label.activated))
    end
  end
end
