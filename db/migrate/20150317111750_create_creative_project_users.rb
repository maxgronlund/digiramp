class CreateCreativeProjectUsers < ActiveRecord::Migration
  def change
    create_table :creative_project_users do |t|
      t.belongs_to :creative_project, index: true
      t.belongs_to :user, index: true
      t.boolean :approved_by_project_manager
      t.boolean :approved_by_user
      t.boolean :locked
      t.string :email
      t.integer :created_by
      t.boolean :writers
      t.boolean :composers
      t.boolean :musicians
      t.boolean :vocals
      t.boolean :dancers
      t.boolean :live_performers
      t.boolean :producers
      t.boolean :studio_facilities
      t.boolean :financial_services
      t.boolean :legal_services
      t.boolean :publichers
      t.boolean :remixers
      t.boolean :audio_engineers
      t.boolean :video_artists
      t.boolean :graphic_artists
      t.boolean :other

      t.timestamps
    end
  end
end
