class RemoveProfessionalInfos < ActiveRecord::Migration
  def change
    drop_table :professional_infos
  end
end
