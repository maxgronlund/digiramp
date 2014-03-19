module KnowDigiRampHelper
  
  def backend_is_prepared
    unless Admin.exists?()
      @admin = Admin.create()
    end
  end
  
  
  
end

World(KnowDigiRampHelper)