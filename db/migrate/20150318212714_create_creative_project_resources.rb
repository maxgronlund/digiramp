class CreateCreativeProjectResources < ActiveRecord::Migration
  def change
    create_table :creative_project_resources do |t|
      t.belongs_to :creative_project, index: true
      t.belongs_to :user, index: true
      t.string :title
      t.text :description
      t.string :file
      t.string :file_size
      t.string :content_type

      t.timestamps
    end
  end
end
