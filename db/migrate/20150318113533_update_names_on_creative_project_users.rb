class UpdateNamesOnCreativeProjectUsers < ActiveRecord::Migration
  def change
    rename_column :creative_project_users, :writers, :writer
    rename_column :creative_project_users, :composers, :composer
    rename_column :creative_project_users, :musicians, :musician
    rename_column :creative_project_users, :vocals, :vocal
    rename_column :creative_project_users, :dancers, :dancer
    rename_column :creative_project_users, :live_performers, :live_performer
    rename_column :creative_project_users, :producers, :producer
    rename_column :creative_project_users, :studio_facilities, :studio_facility
    rename_column :creative_project_users, :financial_services, :financial_service
    rename_column :creative_project_users, :legal_services, :legal_service
    rename_column :creative_project_users, :publichers, :publicher
    rename_column :creative_project_users, :remixers, :remixer
    rename_column :creative_project_users, :audio_engineers, :audio_engineer
    rename_column :creative_project_users, :video_artists, :video_artist
    rename_column :creative_project_users, :graphic_artists, :graphic_artist

    
  end
end


