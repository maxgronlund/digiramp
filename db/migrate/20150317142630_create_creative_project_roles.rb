class CreateCreativeProjectRoles < ActiveRecord::Migration
  def change
    create_table :creative_project_roles do |t|
      t.belongs_to :creative_project, index: true
      t.belongs_to :creative_project_user, index: true
      t.string :instrument
      t.string :other_instrument
      t.boolean :jazz
      t.boolean :rock
      t.boolean :pop
      t.boolean :hip_hop
      t.boolean :edm
      t.boolean :classic
      t.boolean :experimental
      t.string :other_genre
      t.text :description
      t.string :budget
      t.decimal :copyright_split
      t.decimal :master_split
      t.string :role
      t.boolean :live_performance
      t.boolean :online_collaboration
      t.boolean :studio_sessions
      t.string :location
      
      
      t.timestamps
    end
  end
end
