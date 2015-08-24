class User::PublishingTemplatesController < ApplicationController
  before_action :set_publisher
  before_action :access_user
  def index
    @documents   = Document.templates.where(tag: 'Publishing agreement')
  end

  def show
    @document = Document.cached_find(params[:id])
  end

  def new
    
    if params[:uuid]
      
      @template = Document.cached_find(params[:uuid])
      @document = Document.new( text_content: @template.text_content,
                                template_id: @template.id,
                                tag: @template.tag)
    else
      @document = Document.new
    end                         
    @account = @user.account  
    
  end

  def create
    @document = Document.new(document_params)
    @document.uuid = UUIDTools::UUID.timestamp_create().to_s

    
    template_id = params[:document][:template_id]
    params[:document][:template_id] = nil

    
    @document.save!

    if template_id 
      if template = Document.find_by(id: template_id)
        
        template.digital_signatures.each do |digital_signature|
          signature = DigitalSignature.new( signable_id: @document.id,
                                            signable_type: @document.class.name,
                                            role: digital_signature.role
                                            )
          signature.save(validate: false)
        end
      end
    end
    
    DocumentUser.create(document_id: @document.uuid, 
                        user_id: @user.id, 
                        email: @user.email, 
                        status: 0,
                        can_edit: true,
                        should_sign: true )
    
    publishing_agreement  = PublishingAgreement.create( title:        @document.title,
                                                        document_id:  @document.uuid,
                                                        publisher_id: @publisher.id,
                                                        email:        @user.email,
                                                        )
    
    
    
    redirect_to user_user_publisher_publishing_agreement_path(@user, @publisher, publishing_agreement)
    
  end
  
  
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publisher
      @publisher = Publisher.cached_find(params[:publisher_id])
    end
    
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
                                        :uuid,
                                        :expires,
                                        :expiration_date) 
    
    end
    
end
