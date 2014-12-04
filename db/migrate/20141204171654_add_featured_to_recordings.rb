class AddFeaturedToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :featured, :boolean, default: false
  end
end
