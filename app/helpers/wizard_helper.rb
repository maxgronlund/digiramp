module WizardHelper
  
  def get_wizard user_id
    Wizard.where(user_id: user_id, wizard_id: self.id, wizard_type: self.class.name )
          .first_or_create(user_id: user_id, wizard_id: self.id, wizard_type: self.class.name )
  end 

  def end_wizard user_id
    if wizards = Wizard.where(user_id: user_id, wizard_id: self.id, wizard_type: self.class.name )
      wizards.destroy_all
    end
  end
  
end



