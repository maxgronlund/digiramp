class AddUuidToIpis < ActiveRecord::Migration
  def change
    add_column :ipis, :uuid, :string
    
    Ipi.find_each do |ipi|
      ipi.uuid = UUIDTools::UUID.timestamp_create().to_s
      ipi.save!
    end
  end
end
