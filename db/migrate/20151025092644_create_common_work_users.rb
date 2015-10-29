class CreateCommonWorkUsers < ActiveRecord::Migration
  def change
    
    
    
    add_reference :common_works, :user, index: true


    
    create_table :common_work_users do |t|
      t.string :common_work_title
      t.belongs_to :common_work, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.string :publisher_belongs_to
      t.boolean :can_manage_common_work

      t.timestamps null: false
    end
    
    
    
    
    
    CommonWork.find_each do |common_work|
      if account = common_work.account
        common_work.update_columns(
          user_id: account.user_id
        )
        Rails.cache.delete([common_work.class.name, common_work.id])
        create_common_work_users common_work
      else
        common_work.destroy
      end
    end
  end
  
  def create_common_work_users common_work
    
    common_work_user = CommonWorkUser.where(
      common_work_id:           common_work.id,
      user_id:                  common_work.user_id,
    )
    .first_or_create(
      common_work_title:        common_work.title,
      common_work_id:           common_work.id,
      user_id:                  common_work.user_id,
      can_manage_common_work:   true
    )
    create_common_work_users_for_ipis common_work
    
  end
  
  def create_common_work_users_for_ipis common_work
    common_work.common_work_ipis.each do |common_work_ipi|
      create_common_work_users_for_ipi common_work_ipi
    end
  end
  
  def create_common_work_users_for_ipi common_work_ipi
    common_work_user = CommonWorkUser.where(
      common_work_id:           common_work_ipi.common_work_id,
      user_id:                  common_work_ipi.user_id
    )
    .first_or_create(
      common_work_title:        common_work_ipi.common_work.title,
      common_work_id:           common_work_ipi.common_work_id,
      user_id:                  common_work_ipi.user_id,
      can_manage_common_work:   false
    )
  end
end
