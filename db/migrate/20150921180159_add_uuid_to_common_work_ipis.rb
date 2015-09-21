class AddUuidToCommonWorkIpis < ActiveRecord::Migration
  def change
    add_column :common_work_ipis, :uuid, :uuid
    
    CommonWorkIpi.find_each do |common_work_ipi|
      if common_work_ipi.share.nil?
        if common_work = common_work_ipi.common_work
          stakes = common_work.common_work_ipis.count
          common_work_ipi.share =  100.0 / stakes.to_f
        else
          common_work_ipi.share = 100.0
        end
      end
      common_work_ipi.uuid = UUIDTools::UUID.timestamp_create().to_s
      common_work_ipi.save(validate: false)
    end
  end
end
