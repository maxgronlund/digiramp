class User::LegalDocumentsController < ApplicationController
  before_action :access_user
  def index
    @account  = @user.account
    @documents = @account.documents
  end
  
  def new
    if params[:id]
      document = Document.cached_find(params[:id])
      
      @document = Document.new(title: document.title, 
                                body: document.body, 
                                text_content: document.text_content)
    else
      @document = Document.new
    end
    @account = @user.account
    
    
  end
  
  def create
    ap params
    Document.create(document_params)
    redirect_to user_user_legal_documents_path(@user)
  end
  
  def edit
    @account = @user.account
    @document = Document.cached_find(params[:id])
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  private
  
  def document_params
    params.require(:document).permit(:title, :document_type, :body, :file, :usage, :account_id) 
    
  end
  
end


#t.string   "title",         limit: 255
#t.string   "document_type", limit: 255
#t.text     "body"
#t.string   "file",          limit: 255
#t.string   "image_thumb",   limit: 255
#t.integer  "usage"
#t.text     "text_content"
#t.string   "mime",          limit: 255
#t.string   "file_type",     limit: 255
#t.integer  "account_id"
#t.datetime "created_at"
#t.datetime "updated_at"
#t.integer  "file_size",                 default: 0