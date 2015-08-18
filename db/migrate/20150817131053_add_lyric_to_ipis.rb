class AddLyricToIpis < ActiveRecord::Migration
  def change
    
    rename_column :ipis, :writer, :lyric
    rename_column :ipis, :composer, :music
    
    add_column :ipis, :melody, :boolean  , default: false
    add_column :ipis, :arrangement, :boolean  , default: false
    
    
    
    Ipi.update_all(lyric: false, arrangement: false)
    Ipi.find_each do |ipi|
      ipi.melody         = false
      ipi.arrangement    = false
      ipi.save(validate: false)
    end
  end
end
