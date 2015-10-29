class CleanUpIpis < ActiveRecord::Migration
  def change
    remove_column :ipis, :mech_owned, :decimal
    remove_column :ipis, :mech_collected, :decimal
    remove_column :ipis, :perf_owned, :decimal
    remove_column :ipis, :perf_collected, :decimal
    remove_column :ipis, :has_agreement,    :boolean
    remove_column :ipis, :linked_to_ascap_member,    :boolean
    remove_column :ipis, :controlled_by_submitter,    :boolean
    remove_column :ipis, :ascap_work_id,    :string
    remove_column :ipis, :bmi_work_id,    :string
    remove_column :ipis, :lyric,    :boolean
    remove_column :ipis, :music,    :boolean
    remove_column :ipis, :administrator,    :boolean
    remove_column :ipis, :producer,    :boolean
    remove_column :ipis, :original_publisher,    :boolean
    remove_column :ipis, :artist,    :boolean
    remove_column :ipis, :distributor,    :boolean
    remove_column :ipis, :remixer,    :boolean
    remove_column :ipis, :other,    :boolean
    remove_column :ipis, :publisher,    :boolean
    remove_column :ipis, :show_credit_on_recordings,    :boolean
    remove_column :ipis, :title,    :string
    remove_column :ipis, :message,    :text
    remove_column :ipis, :ipi_id,    :integer
    remove_column :ipis, :melody,    :boolean
    remove_column :ipis, :arrangement,    :boolean
    remove_column :ipis, :i_am_the_publishing_designee,    :boolean
    remove_column :ipis, :publishing_designee,    :boolean
    remove_column :ipis, :master_ipi,    :boolean
    
    remove_column :ipis, :common_work_id,    :integer
    remove_column :ipis, :import_ipi_id,    :integer
    remove_column :ipis, :controlled,    :boolean
    remove_column :ipis, :territory,    :string
    remove_column :ipis, :share,    :decimal
    remove_column :ipis, :notes,    :text
    remove_column :ipis, :confirmation,    :string
    remove_column :ipis, :status,    :integer
    remove_column :ipis, :phone_number,    :string
    remove_column :ipis, :role,    :string
    

    Ipi.find_each do |ipi|
      Rails.cache.delete([ipi.class.name, ipi.id])
    end
    
  end
end
