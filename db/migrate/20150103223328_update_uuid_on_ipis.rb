class UpdateUuidOnIpis < ActiveRecord::Migration
  def change
    
    Ipi.find_each do |ipi|
      if ipi.uuid.to_s == ''
        ipi.uuid = UUIDTools::UUID.timestamp_create().to_s
        ipi.save!
      end
    end
    
    
  end
end
