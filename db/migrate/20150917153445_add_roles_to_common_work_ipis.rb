class AddRolesToCommonWorkIpis < ActiveRecord::Migration
  def change
    
    add_column :common_work_ipis, :lyric, :boolean
    add_column :common_work_ipis, :music, :boolean
    add_column :common_work_ipis, :melody, :boolean
    add_column :common_work_ipis, :arrangement, :boolean
    add_column :common_work_ipis, :share, :decimal
    add_column :common_work_ipis, :show_on_recordings, :boolean
    add_column :common_work_ipis, :status, :integer
    add_column :common_work_ipis, :notes, :text
    add_column :common_work_ipis, :ascap_work_id, :integer
    add_column :common_work_ipis, :bmi_work_id, :integer
    add_column :common_work_ipis, :email, :string
    add_column :common_work_ipis, :alias, :string
    add_column :common_work_ipis, :full_name, :string
    
   
    
    CommonWorkIpi.find_each do |common_work_ipi|
      
      
      user = common_work_ipi.ipi.user

      common_work_ipi.update(
      
        lyric:                    common_work_ipi.ipi.lyric,
        music:                    common_work_ipi.ipi.music,
        melody:                   common_work_ipi.ipi.melody,
        arrangement:              common_work_ipi.ipi.arrangement,
        share:                    common_work_ipi.ipi.share,
        show_on_recordings:       common_work_ipi.ipi.show_credit_on_recordings,
        status:                   common_work_ipi.ipi.status,
        notes:                    common_work_ipi.ipi.notes,
        ascap_work_id:            common_work_ipi.ipi.ascap_work_id,
        bmi_work_id:              common_work_ipi.ipi.bmi_work_id,
        email:                    common_work_ipi.ipi.email,
        full_name:                user ? user.full_name : nil,
        alias:                    user ? user.user_name : nil
      )
    end
    
  end
end
