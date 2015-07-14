class Wizard::Rights::WizardController < ApplicationController
  
  before_action :find_model_and_grand_access
  
  

  
  
  private
  
  def find_model_and_grand_access
    @common_work = ::CommonWork.find(params[:common_work_id])
    @wizard = ::Wizard.cached_find(params[:id]) if params[:id]
  end
end
