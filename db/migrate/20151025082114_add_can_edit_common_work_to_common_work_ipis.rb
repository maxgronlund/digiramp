class AddCanEditCommonWorkToCommonWorkIpis < ActiveRecord::Migration
  def change
    add_column :common_work_ipis, :can_edit_common_work, :boolean, default: false
    
    CommonWorkIpi.find_each do |common_work_ipi|
      
      if common_work_ipi_user = common_work_ipi.user
        
        if common_work = common_work_ipi.common_work
          
          if common_work_account = common_work.account
            
            common_work_ipi.update_columns(can_edit_common_work: common_work_ipi_user == common_work_account.user)
          else
            common_work.destroy
            ap 'deleted common_work without an account'
          end
        else
          common_work_ipi.destroy
          ap 'deleted common_work_ipi without a common_work'
        end
      end
      
      Rails.cache.delete([common_work_ipi.class.name, common_work_ipi.id])
    end
  end
end
