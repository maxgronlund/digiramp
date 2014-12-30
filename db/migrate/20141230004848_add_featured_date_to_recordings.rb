class AddFeaturedDateToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :featured_date, :datetime
    
    Recording.find_each do |recording|
      recording.featured_date = DateTime.now 
      recording.save!
    end
  end
end
