class PermittedModelType < ActiveRecord::Base
  #after_create :add_to_users
  after_destroy :remove_from_users
  
  validates_uniqueness_of :id_name
  validates_uniqueness_of :ui_name
  
  validates_length_of :id_name, minimum: 2, allow_blank: false
  validates_length_of :ui_name, minimum: 2, allow_blank: false
  
  def add_to_account_users
    AccountUser.all.each do |account_user|
      add_to_account_user(account_user)
    end
  end
  
  def add_to_account_user(account_user)
    account_user.permitted_models.where(permitted_model_type_id: id).first_or_create
  end
  
  def remove_from_account_users
    AccountUser.all.each do |account_user|
      remove_from_account_user(account_user)
    end
  end
  
  def remove_from_account_user(account_user)
    account_user.permitted_models.where(permitted_model_type_id: id).delete_all
  end

  def remove_from_users
    AccountUser.all.each do |account_user|
      account_user.permitted_models.where(permitted_model_type_id: id).delete_all
    end
  end
  
  def self.initiallize_permitted_model_types
    find_or_create_permitted_model_type false, false, false, false, "Catalogs",             "Catalogs" 
    find_or_create_permitted_model_type false, false, false, false, "Documents",            "Document"  
    find_or_create_permitted_model_type true,  true,  true,  true,  "Activity events",      "ActivityEvents"  
    find_or_create_permitted_model_type false, false, false, false, "Assign Permissions",   "AssignPermission"  
    find_or_create_permitted_model_type false, true,  false, false, "Recordings",           "Recording"  
    find_or_create_permitted_model_type false, true,  false, false, "Common Works",         "CommonWork"  
    find_or_create_permitted_model_type false, true,  false, false, "Users",                "User"  
    find_or_create_permitted_model_type false, true,  false, false, "Playlists",            "Playlist"  
    find_or_create_permitted_model_type true,  true,  true,  true,  "Ipi Shares",           "IpiShare"  
    find_or_create_permitted_model_type true,  true,  true,  true,  "Ipi's",                "Ipi"  
    find_or_create_permitted_model_type true,  true,  true,  true,  "Movie Projects",       "MovieProject"  
    find_or_create_permitted_model_type true,  true,  true,  true,  "Music Opportunities",  "MusicOpportunity"
  end
  
  def self.find_or_create_permitted_model_type c, r, u, d, ui_name, id_name
    PermittedModelType.where(c: c, r: r, u: u, d: d, ui_name: ui_name, id_name: id_name ).first_or_create(c: c, r: r, u: u, d: d, ui_name: ui_name, id_name: id_name )
  end
  
  #def remove_from_user(user)
  #  user.permitted_models.where(permitted_model_type_id: id).delete_all
  #end

end
