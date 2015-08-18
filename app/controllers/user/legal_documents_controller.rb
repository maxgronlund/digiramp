class User::LegalDocumentsController < ApplicationController
  before_action :access_user
  def index
    @account  = @user.account
    @documents = @account.documents
  end
  
  def show
    @document = Document.cached_find(params[:id])
    @account  = @user.account
    
    respond_to do |format|
      format.html
      format.pdf do
        @document.text_content =  @document.text_content.gsub('*| PURCHASERS_EMAIL |*', "<img src=" + '"https://digiramp.s3.amazonaws.com/uploads/digital_signature/image/1/image_300x50_Max_signature.png"' +     ">")
        
        
        render :pdf => @document.title.gsub(' ', '_').downcase, layout: "contracts"
      end
    end
    
    
  end
  
  def new
    if params[:uuid]
      
      @template = Document.cached_find(params[:uuid])
      @document = Document.new( title: @template.title, 
                                body: @template.body, 
                                text_content: @template.text_content,
                                template_id: @template.id,
                                tag: @template.tag)
                                
                                
    else
      @document = Document.new
    end
    @account = @user.account
    @legal_tags = Admin::LegalTag.order(:title)
    
  end
  
  def create
    
    @document = Document.new(document_params)
    @document.save!

    
    if @document.template_id 
      if template = Document.find_by(id: @document.template_id)
        
        template.digital_signatures.each do |digital_signature|
          signature = DigitalSignature.new( signable_id: @document.id,
                                            signable_type: @document.class.name,
                                            role: digital_signature.role
                                            )
          signature.save(validate: false)
        end
        
      end
    end
    
    
    
      
    
    redirect_to user_user_legal_documents_path(@user)
  end
  
  def edit
    @account = @user.account
    @document = Document.cached_find(params[:id])
  end
  
  def update
     @document = Document.cached_find(params[:id])
     

     #params[:document][:text_content] =  params[:document][:text_content].gsub('*| PURCHASERS_EMAIL |*', 'max@synthmax.dk')
     
     if @document.update(document_params)
       ap '================================ updated ==========================================='
       ap @document.text_content
       redirect_to user_user_legal_documents_path(@user)
     else
       render edit
     end
  end
  
  def destroy
    begin
      document = Document.cached_find(params[:id])
      document.destroy!
    rescue
      flash[:danger] = "You can't delete a document used" 
    end
    redirect_to user_user_legal_documents_path(@user)
  end
  
  private
  
  def document_params
    params.require(:document).permit( :title, 
                                      :document_type, 
                                      :body, 
                                      :file, 
                                      :usage, 
                                      :account_id, 
                                      :text_content,
                                      :template_id,
                                      :tag,
                                      :uuid) 
    
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