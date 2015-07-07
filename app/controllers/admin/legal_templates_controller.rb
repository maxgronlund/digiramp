class Admin::LegalTemplatesController < ApplicationController
  before_action :admins_only
  
  def index
    @documents   = Document.templates
    @system_user = User.system_user
    @account     = @system_user.account
  end

  def show
    @document = Document.cached_find(params[:id])
  end

  def new
    @document      = Document.new
    @system_user   = User.system_user
    @account       = @system_user.account
  end
  
  def create
    @document = Document.create(document_params)
    redirect_to admin_legal_template_path @document
  end

  def edit
    @document    = Document.cached_find(params[:id])
    @system_user   = User.system_user
    @account       = @system_user.account
  end
  
  def update
     @document    = Document.cached_find(params[:id])
     @document.update(document_params)
     redirect_to admin_legal_template_path @document
  end
  
  private 
  
  def document_params
    params.require(:document).permit(:title, 
                                     :document_type, 
                                     :body, 
                                     :file, 
                                     :usage, 
                                     :account_id, 
                                     :text_content) 
    
  end
end
