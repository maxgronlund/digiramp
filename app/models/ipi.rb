class Ipi < ActiveRecord::Base
  
  has_many :activity_events, as: :activity_eventable
  
  belongs_to :common_work
  belongs_to :import_ipi
  belongs_to :user
  
  ##attr_accessible :address, 
  #                :email, 
  #                :full_name, 
  #                :phone_number, 
  #                :role, 
  #                :import_ipi_id, 
  #                :common_work_id, 
  #                :user_id, 
  #                :controlled,
  #                :territory, 
  #                :share,
  #                :mech_owned,
  #                :mech_collected,
  #                :perf_owned,
  #                :perf_collected,
  #                :sync_collected,
  #                :notes,
  #                :cae_code,
  #                :ipi_code
  #
  
  ROLES = ["Client", "Administrator", "Producer", "Original Publisher", "Composer", "Writer", "Artist", "Distributor", "Remixer"]
  

end


