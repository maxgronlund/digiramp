class Account::ClientImportsController < ApplicationController
  before_action :set_client_import, only: [:show, :edit, :update, :destroy]
  include AccountsHelper
  include Transloadit::Rails::ParamsDecoder
  before_filter :access_account



  # GET /client_imports/new
  def new
    @client_import = ClientImport.new
  end



  # POST /client_imports
  # POST /client_imports.json
  def create
    @client_import = ClientImport.create(client_import_params)
    
    ClientCsvImportWorker.perform_async( @client_import.id )
    

    #if documents
    #  documents.each do |document|
    #    #ClientCsvImportWorker.perform_async( document.id )
    #    CSV.foreach(document.file, headers: true) do |row|
    #      #Product.create! row.to_hash
    #      ap row.to_hash
    #    end
    #  end
    #end

    redirect_to account_account_clients_path(@account)
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_import
      @client_import = ClientImport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_import_params
      params.require(:client_import).permit(:account_id, :user_uuid, :file)
    end
end
