class CreateIssueEvents < ActiveRecord::Migration
  def change
    create_table :issue_events do |t|
      t.string :title
      t.text :data
      t.references :subject, polymorphic: true, index: true

      t.timestamps
    end
  end
end
