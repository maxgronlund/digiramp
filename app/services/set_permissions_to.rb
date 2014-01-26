class SetPermissionsTo
  
  def initialize
  end
  
  def self.catalog_owner account_user
    set_permitted_model account_user, "MusicOpportunity", false,  false, false, false
    set_permitted_model account_user, "ActivityEvents",   true ,  true , true , true
    set_permitted_model account_user, "Catalogs",         true ,  true , true , true
  end
  
  def self.supervisor account_user
    set_permitted_model account_user, "MusicOpportunity", true,   true,  true,  true
    set_permitted_model account_user, "ActivityEvents",   true,   true,  true,  true
    set_permitted_model account_user, "Catalogs",         false,  false, false, false
  end
  
  def self.set_permitted_model account_user, permitted_model_type_id_name, c, r, u, d
    permitted_model_type  = PermittedModelType.where(id_name: permitted_model_type_id_name).first
    permitted_model       = PermittedModel.where(account_user_id: account_user.id, permitted_model_type_id: permitted_model_type.id  ).first
    permitted_model.c     = c
    permitted_model.r     = r
    permitted_model.u     = u
    permitted_model.d     = d
    permitted_model.save!
  end
  
end


