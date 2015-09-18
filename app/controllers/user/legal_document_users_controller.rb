class User::LegalDocumentUsersController < ApplicationController
  before_action :access_user
  
  def new
    @document       = Document.cached_find(params[:legal_document_id])
    @document_user  = DocumentUser.new
  end

  def create
    @document       = Document.cached_find(params[:legal_document_id])
    
    if @document_user  = DocumentUser.create(document_user_params)
      @document_user.assign_to_user
      if go_to = session[:sign_document]
        session[:sign_document] = nil
        redirect_to go_to
      else
        redirect_to user_user_legal_documents_path(@user, @document.uuid)
      end
    else
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
    if go_to = session[:sign_document]
      session[:sign_document] = nil
      redirect_to go_to
    else
      redirect_to user_user_legal_documents_path(@user, @document.uuid)
    end
    

  end

  def destroy
    @document       = Document.cached_find(params[:legal_document_id])
    @document_user = DocumentUser.cached_find(params[:id])
    unless @document_user.signature
      @document_user.destroy
    end
  end
  
  private
  
  def document_user_params
    if editor?
      params.require(:document_user).permit!
    end 
  end   
end
