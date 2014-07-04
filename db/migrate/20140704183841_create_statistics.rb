class CreateStatistics < ActiveRecord::Migration
  def up
    create_table :statistics do |t|
      t.integer :recordings
      t.integer :common_works
      t.integer :users
      t.integer :catalogs

      t.timestamps
    end
    
    stats = Statistics.new
    
    stats.recordings      = Recording.all.size
    stats.common_works    = CommonWork.all.size
    stats.users           = User.all.size
    stats.catalogs        = Catalog.all.size
    stats.save!
  end
  
  def down
    
    
  end
end
