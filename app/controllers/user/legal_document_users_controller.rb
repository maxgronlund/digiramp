class User::LegalDocumentUsersController < ApplicationController
  before_action :access_user
  
  def new
    @document       = Document.cached_find(params[:legal_document_id])
    @document_user  = DocumentUser.new
  end

  def create
    
    begin
      @document       = Document.cached_find(params[:legal_document_id])
      @document_user  = DocumentUser.create(document_user_params)
      @document_user.assign_to_user
      redirect_to_special_url user_user_legal_documents_path(@user, @document.uuid)
    rescue => e
      ErrorNotification.post_object 'User::PublishingDesigneesController#find_or_create_common_work_ipi', e
      render :new
    end

  end

  def edit
    ap params
    @document       = Document.cached_find(params[:legal_document_id])
    @document_user = DocumentUser.cached_find(params[:id])
  end

  def update
    ap params
    @document       = Document.cached_find(params[:legal_document_id])
    @document_user  = DocumentUser.cached_find(params[:id])
    @document_user.update(document_user_params)
    @document_user.assign_to_user
    
    redirect_to_special_url user_user_legal_documents_path(@user, @document.uuid)


  end

  def destroy
    @document       = Document.cached_find(params[:legal_document_id])
    @document_user  = DocumentUser.cached_find(params[:id])
    
    unless @document_user.signature
      @document_user_id = @document_user.id
      @document_user.destroy
    else
      render nothing: true
    end
  end
  
  private
  
  def document_user_params
    params.require(:document_user).permit!
  end   
end
