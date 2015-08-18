class User::SelectTemplatesController < ApplicationController
  before_action :access_user
  def index
    
    #case params[:selection]
    #when 'im the only owner'
    #  @documents   = Document.templates
    #end
    
    @documents   = Document.templates
  end
  
  def show
    redirect_to new_user_user_legal_document_path(uuid: params[:id])
  end
  
  
end
