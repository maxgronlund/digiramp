class User::SelectTemplatesController < ApplicationController
  before_action :access_user
  def index
    
    case params[:selection]
      
    when 'im the only owner'
    
      @documents   = Document.templates
      
      
    end
    @documents   = Document.templates
  end
  
  def show
    
    
    document = Document.cached_find(params[:id])
    #@document = Document.new(title: document.title, 
    #                          body: document.body, 
    #                          text_content: document.text_content)
    #
    redirect_to new_user_user_legal_document_path(id: document.id)
  end
  
  
end
