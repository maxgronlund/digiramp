class AddRolesToIpis < ActiveRecord::Migration
  def change
    add_column :ipis, :writer, :boolean               , default: false
    add_column :ipis, :composer, :boolean             , default: false
    add_column :ipis, :administrator, :boolean        , default: false
    add_column :ipis, :producer, :boolean             , default: false
    add_column :ipis, :original_publisher, :boolean   , default: false
    add_column :ipis, :artist, :boolean               , default: false
    add_column :ipis, :distributor, :boolean          , default: false
    add_column :ipis, :remixer, :boolean              , default: false
    add_column :ipis, :other, :boolean                , default: false
    add_column :ipis, :publisher, :boolean            , default: false
    
    Ipi.find_each do |ipi|
      case ipi.role
      when "Writer"
        ipi.writer = true
      when  "Composer"
        ipi.composer = true
      when  "Administrator"
        ipi.administrator = true
      when  "Producer"
        ipi.producer = true
      when  "Original Publisher"
        ipi.original_publisher = true
      when   "Artist"
        ipi.artist = true
      when  "Distributor"
        ipi.distributor = true
      when  "Remixer"
        ipi.remixer = true
      when  "Other"
        ipi.other = true
      when  "Publisher" 
        ipi.publisher = true
      end
      ipi.save!
    end
  end
end
