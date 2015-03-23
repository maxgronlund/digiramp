class CreateCreativeProjects < ActiveRecord::Migration
  def change
    create_table :creative_projects do |t|
      t.string :title
      t.text :description
      t.belongs_to :user, index: true
      t.belongs_to :account, index: true
      t.boolean :public_project
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
      t.string :other
      t.boolean :locked, default: false
      t.date :deadline

      t.timestamps
    end
  end
end
