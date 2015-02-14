class Catalog::FinancialDocumentsController < ApplicationController
  
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  include CatalogsHelper
  
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_filter :access_account
  before_filter :access_catalog
  
  
  def index
                                
    @financial_documents = Document.catalogs_search( @catalog.documents.where(document_type: 'Financial Document'), params[:query]).order('title asc').page(params[:page]).per(24) 
    
  end

  def show

  end

  def new
    
  end

  def edit
    
  end
  
  def create
    forbidden unless current_account_user.create_financial_document
    
    documents = TransloaditDocumentsParser.parse params[:transloadit], @account.id
    if documents
      documents.each do |document|
        document.document_type = 'Financial Document'
        document.save!
        CatalogsDocuments.where(catalog_id: @catalog.id, document_id: document.id)
                         .first_or_create(catalog_id: @catalog.id, document_id: document.id)
        
        DocumentExtractTextWorker.perform_async( document.id )
      end
    end
    redirect_to catalog_account_catalog_financial_documents_path(@account, @catalog)
  end
  
  def update
    @document.update_attributes(document_params)
    redirect_to catalog_account_catalog_financial_document_path(@account, @catalog, @document)
  end
  
  def destroy
    forbidden unless current_account_user.delete_financial_document
    document = Document.cached_find(params[:id])
    document.destroy!
    redirect_to :back
    
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.cached_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit!
    end
end
