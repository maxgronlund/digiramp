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
    
    ClientCsvImportWorker.perform_async( @client_import.id, current_user.email )
    flash[:info] = { title: "Info: ", body: "This might take a little time. You will see a notification when done" }


    redirect_to account_account_clients_path(@account)
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_import
      @client_import = ClientImport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_import_params
      params.require(:client_import).permit!
    end
end
