class WizardValidator < ActiveModel::Validator
  
  def validate(record)
    
    case record.wizard_type
    when 'CommonWork'
      validate_common_work record
    end
  end
  
  def validate_common_work record
    ap 'validate_common_work'
    ap record.content[:work_contributor_count].to_i
    if record.content[:work_contributor_count].to_i < 0
      ap "can't be less than 1"
      record.errors[:work_contributor_count] << "can't be less than 1"
    end
    
    #if record.work_contributor_count && record.content.work_contributor_count.to_i < 0
    #  record.errors[:work_contributor_count] << "can't be less than 1"
    #end
  end
  
 
  
end