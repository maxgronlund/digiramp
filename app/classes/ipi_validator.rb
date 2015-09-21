class IpiValidator < ActiveModel::Validator
  def validate(record)
    #common_work = record.common_work
    #
    #total_share = 0.0
    #
    #common_work.ipis.each do |ipi|
    #  total_share += ipi.share unless ipi == record
    #end
    #
    #if total_share + record.share > 100.0
    #  record.errors[:share] << "Total share of all ips can be greater then 100%"
    #end

  end
end

