class AddUuidToCommonWorks < ActiveRecord::Migration
  def change
    add_column :common_works, :uuid, :string
    add_column :recordings, :uuid, :string
    CommonWork.all.each do |common_work|
      common_work.uuid = UUIDTools::UUID.random_create().to_s
      common_work.save!
    end
    Recording.all.each do |recording|
      recording.uuid = UUIDTools::UUID.random_create().to_s
      recording.save!
    end
  end
end
