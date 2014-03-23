class UpdateCompletenesOnRecordings < ActiveRecord::Migration
  def change
    
    change_column :recordings, :isrc_code, :string,                      default: ''
    change_column :recordings, :artists, :text,                         default: ''
    change_column :recordings, :lyrics, :text,                           default: ''
    change_column :recordings, :bpm, :integer,                           default: 0
    change_column :recordings, :instrumental, :boolean,                  default: false
    change_column :recordings, :description, :text,                      default: ''
    change_column :recordings, :explicit, :boolean,                      default: false
    change_column :recordings, :clearance, :boolean,                     default: false
    change_column :recordings, :production_company,  :string,            default: ''
    change_column :recordings, :upc_code,  :string,                      default: ''
    change_column :recordings, :has_title, :boolean,                     default:  false
    change_column :recordings, :has_lyrics, :boolean,                    default: false
    change_column :recordings, :completeness_in_pct, :integer,           default: 0
    change_column :recordings, :category,  :string,                      default: ''
    add_column    :recordings, :cache_version_temp,  :integer,           default: 0


    
    Recording.all.each do |recording|
      
      recording.cache_version_temp = recording.cache_version.to_i
      
      if recording.isrc_code.nil?
        recording.isrc_code = ''
      end
      
      if recording.lyrics.nil?
        recording.lyrics = ''
      end
      
      if recording.artists.nil?
        recording.artists = ''
      end
      
      if recording.bpm.nil?
        recording.bpm = 0
      end
      
      if recording.instrumental.nil?
        recording.instrumental = false
      end
      
      if recording.description.nil?
        recording.description = ''
      end
      
      if recording.explicit.nil?
        recording.explicit = false
      end
      
      if recording.clearance.nil?
        recording.clearance = false
      end
      
      if recording.production_company.nil?
        recording.production_company = ''
      end
      
      if recording.upc_code.nil?
        recording.upc_code = ''
      end
      
      if recording.has_title.nil?
        recording.has_title = false
      end
      
      if recording.has_lyrics.nil?
        recording.has_lyrics = false
      end
      
      if recording.completeness_in_pct.nil?
        recording.completeness_in_pct = 0
      end
      
      if recording.category.nil?
        recording.category = ''
      end
      
      if recording.cache_version.nil?
        recording.cache_version = 0
      end
      recording.update_completeness
    end
    
    remove_column :recordings, :cache_version
    add_column    :recordings, :cache_version,  :integer,                 default: 0
    
    Recording.all.each do |recording|
      recording.cache_version = recording.cache_version_temp
      recording.update_completeness
    end

    remove_column  :recordings, :cache_version_temp

  end
end
