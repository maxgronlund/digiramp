class PermittedParams < Struct.new(:params, :user)

  #def gallery
  #  if user.admin_or_super?
  #    params.require(:gallery).permit!
  #  end
  #end
  #
  #def artwork
  #  if user.admin_or_super?
  #    params.require(:artwork).permit!
  #  end
  #end
  

  
  #def beacon
  #  params.require(:beacon).permit(*beacon_attributes)
  #end
  #
  #def beacon_attributes
  #  if user.super?
  #    [:name, :email, :role]
  #  elsif user.admin
  #    [:name, :email]
  #  else
  #    [:name, :email]
  #  end
  #end
  
  
end
