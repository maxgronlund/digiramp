class Admin::LegalTemplatesController < ApplicationController
  before_action :admins_only
  
  def index
    @documents   = Document.templates
    @system_user = User.system_user
    @account     = @system_user.account
  end

  def show
    @document = Document.cached_find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => @document.title.gsub(' ', '_').downcase, layout: "contracts"
      end
    end
  end

  def new
    @document      = Document.new
    @system_user   = User.system_user
    @account       = @system_user.account
  end
  
  def create
    params[:document][:title] = saintize_title params[:document][:title]
    params[:document][:text_content] = sanitize_content params[:document][:text_content]
    @document = Document.create(document_params)
    redirect_to admin_legal_template_path @document
  end

  def edit
    @document    = Document.cached_find(params[:id])
    @system_user   = User.system_user
    @account       = @system_user.account
  end
  
  def update
    params[:document][:title] = saintize_title params[:document][:title]
    params[:document][:text_content] = sanitize_content params[:document][:text_content]
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
  
  def saintize_title title
    title.downcase.capitalize
  end
  
  def sanitize_content content
    content.gsub('&nbsp;', ' ')
  end
end
