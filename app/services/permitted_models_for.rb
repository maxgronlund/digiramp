class PermittedModelsFor
  
  def initialize
  end
  
  def self.account_user account_user
    permitted_models = []
    
    PermittedModelType.all.each do |permitted_model_type|
      permitted_models << PermittedModel.where(  account_user_id: account_user.id, permitted_model_type_id:  permitted_model_type.id)
                                                  .first_or_create(
                                                    account_user_id:          account_user.id,
                                                    permitted_model_type_id:  permitted_model_type.id,
                                                    c:                        permitted_model_type.c,
                                                    r:                        permitted_model_type.r,
                                                    u:                        permitted_model_type.u,
                                                    d:                        permitted_model_type.d
                                                  )
                                                  
    
    end
    permitted_models
  end
  
  #def self.supervisor account_user
  #  permitted_model_type  = PermittedModelType.where(id_name: "MusicOpportunity").first
  #  permitted_model       = PermittedModel.where(account_user_id: account_user.id, permitted_model_type_id: permitted_model_type.id  ).first_or_create(c: true, r: true, u: true, d: true, permitted_model_type_id: permitted_model_type.id, account_user_id: account_user.id )
  #  permitted_model.c     = true
  #  permitted_model.r     = true
  #  permitted_model.u     = true
  #  permitted_model.d     = true
  #  permitted_model.save!
  #end
  
end


