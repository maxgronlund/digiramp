class CleanUpCommonWorks < ActiveRecord::Migration
  def change
    remove_column :common_works, :audio_file            ,:string
    remove_column :common_works, :recording_preview_id  ,:string
    remove_column :common_works, :artwork               ,:string
    remove_column :common_works, :ascap_award_winner    ,:string
    remove_column :common_works, :composite_type        ,:string
    remove_column :common_works, :genre                 ,:string
    remove_column :common_works, :submitter_work_id     ,:string
    remove_column :common_works, :pro_work_id           ,:string
    remove_column :common_works, :pro_catalog           ,:string
    remove_column :common_works, :bmi_catalog,            :string
    remove_column :common_works, :bmi_work_id,            :string
  end
end
