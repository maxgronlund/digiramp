class SetStatusOnCommonWorkIpis < ActiveRecord::Migration
  def change
    
    CommonWorkIpi.find_each do |common_work_ipi|
      if common_work_ipi.user_id.nil?
        common_work_ipi.update_columns(status: 0)
        
      elsif common_work_ipi.status.nil?
        begin
          if common_work_ipi.common_work.account.user_id == common_work_ipi.user_id
            common_work_ipi.update_columns(status: 2)
          else
            if ipi = common_work_ipi.ipi
              if ipi.accepted?
                common_work_ipi.update_columns(status: 2)
              else
                common_work_ipi.update_columns(status: 0)
              end
            end
          end
        rescue
          ap common_work_ipi.id
        end
        
      end
      
      if common_work_ipi.pending? &&  common_work_ipi.user

        UserNotification.where( 
            user_id:    common_work_ipi.user_id,
            asset_type: common_work_ipi.class.name,
            asset_id:   common_work_ipi.id,
            status:     'notice',
            message:    'Confirm role'
          ).first_or_create( 
            user_id:    common_work_ipi.user_id,
            asset_type: common_work_ipi.class.name,
            asset_id:   common_work_ipi.id,
            status:     'notice',
            message:    'Confirm role'
          )

      end
    end
  end
end
