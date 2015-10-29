class CreateCommonWorkIpiPublishers < ActiveRecord::Migration
  def change
    create_table :common_work_ipi_publishers do |t|
      t.belongs_to :common_work_ipi, index: true, foreign_key: false
      t.belongs_to :publisher, index: true, foreign_key: false
      t.decimal :publishing_split
      t.belongs_to :publishing_agreement, index: true

      t.timestamps null: false
    end
    
    add_foreign_key :common_work_ipi_publishers, :common_work_ipis, on_delete: :cascade
    add_foreign_key :common_work_ipi_publishers, :publishers, on_delete: :cascade
    
    
    
    CommonWorkIpi.find_each do |common_work_ipi|
      connect_to_user common_work_ipi
      
      create_common_work_ipi_publisher common_work_ipi
    end
      
    
  end
  
  def connect_to_user common_work_ipi
    
    unless common_work_ipi.email.blank?
      
      if user = User.find_by_email( common_work_ipi.email )
        common_work_ipi.update(user_id: user.id)
      end
    end
    
    unless common_work_ipi.user
      if ipi = common_work_ipi.ipi
        if user = ipi.user
           common_work_ipi.update(user_id: user.id)
        end
      end
    end
  end
  
  def create_common_work_ipi_publisher common_work_ipi
    
    if user = common_work_ipi.user
    
      if user.personal_publishing_status == "I own and control my own publishing"
        
        if publisher = user.personal_publisher
          CommonWorkIpiPublisher.where(
            common_work_ipi_id:           common_work_ipi.id,
            publisher_id:                 publisher.id,
            publishing_agreement_id:      user.personal_publishing_agreement.id,
          )
          .first_or_create(
            common_work_ipi_id:           common_work_ipi.id,
            publisher_id:                 publisher.id,
            publishing_agreement_id:      user.personal_publishing_agreement.id,
            publishing_split:             0.0
          )
        else
          ap 'publisher is missing for user'
          ap user.id
        end
      else
        ap 'User publishing status is: '
        ap user.personal_publishing_status
      end
    else
      ap 'no user attached to common_work_ipi'
      ap common_work_ipi.id
    end
    
  end
end
