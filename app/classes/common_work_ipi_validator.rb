class CommonWorkIpiValidator < ActiveModel::Validator
  def validate(record)
    common_work = record.common_work
    
    total_share = 0.0

    common_work.common_work_ipis.each do |common_work_ipi|
      total_share += common_work_ipi.share.to_f unless common_work_ipi == record
    end

    if total_share + record.share > 100.0
      record.errors[:share] << "Total share of all ips can be greater then 100%"
    end

  end
end

