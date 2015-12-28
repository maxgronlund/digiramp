# Check that the total revenue don't ad op to more than 100%

class StakeValidator < ActiveModel::Validator
  def validate(record)
    total_split = record.split
    
    if record.asset_type == "Stake"
      stake = Stake.cached_find(record.asset_id)
      stake.stakeholders.each do |stake|
        unless record == stake
          total_split += stake.split
        end
      end
    end

    if total_split > 100.0
      record.errors[:split] << "Total split can't be greater than 100%"
    end
    #ap record
  end
end