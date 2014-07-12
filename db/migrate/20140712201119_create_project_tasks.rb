class CreateProjectTasks < ActiveRecord::Migration
  def change
    create_table :project_tasks do |t|
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true
      t.string :title
      t.string :category
      t.string :status
      t.date :due_date
      t.date :start_date
      t.datetime :reminder
      t.string :priority
      t.text :description

      t.timestamps
    end
    
  end
end
