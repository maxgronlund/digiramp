class Catalog::DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  include CatalogsHelper

  
  before_filter :access_account
  before_filter :access_catalog

  # GET /documents
  # GET /documents.json
  def index                         
    @documents = Document.catalogs_search( @catalog.documents , params[:query]).order('title asc').page(params[:page]).per(24) 
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    
  end

  # GET /documents/new
  def new

  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    
    forbidden unless current_account_user.create_legal_document
    if params[:transloadit]
      documents = TransloaditDocumentsParser.parse params[:transloadit], @account.id
      if documents
        documents.each do |document|
          
          CatalogsDocuments.where(catalog_id: @catalog.id, document_id: document.id)
                           .first_or_create(catalog_id: @catalog.id, document_id: document.id)
          
          DocumentExtractTextWorker.perform_async( document.id )
        end
      end
    end
    redirect_to catalog_account_catalog_documents_path(@account, @catalog)
    
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    @document.update_attributes(document_params)
    redirect_to catalog_account_catalog_document_path(@account, @catalog, @document)
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    forbidden unless current_account_user.delete_legal_document
    document = Document.cached_find(params[:id])
    document.destroy!
    redirect_to catalog_account_catalog_documents_path(@account, @catalog)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit!
    end
end
