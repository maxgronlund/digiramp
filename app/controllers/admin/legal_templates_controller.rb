class Admin::LegalTemplatesController < ApplicationController
  before_action :admins_only
  
  def index
    @documents   = Document.templates
    @system_user = User.system_user
    @account     = @system_user.account
    Admin::LegalTag.build_default_tags
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
    if Rails.env.test?
      @document      = Document.new(text_content: 'fobar')
    else
      @document      = Document.new
    end
    @system_user   = User.system_user
    @account       = @system_user.account
    @legal_tags    = Admin::LegalTag.order(:title)
  end
  
  def create
    params[:document][:title] = saintize_title params[:document][:title]
    params[:document][:text_content] = sanitize_content params[:document][:text_content]
    @document = Document.create(document_params)
    redirect_to admin_legal_template_path @document
  end

  def edit
    @document      = Document.cached_find(params[:id])
    @system_user   = User.system_user
    @account       = @system_user.account
    @legal_tags    = Admin::LegalTag.order(:title)
  end
  
  def update
    params[:document][:title] = saintize_title params[:document][:title]
    params[:document][:text_content] = sanitize_content params[:document][:text_content]
    @document    = Document.cached_find(params[:id])
    @document.update(document_params)
    redirect_to admin_legal_templates_path
  end
  
  def destroy
    @document    = Document.cached_find(params[:id])
    @document.destroy
    redirect_to admin_legal_templates_path
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
