class User::FromCsvController < ApplicationController
  before_action :access_user
  include AccountsHelper
  
  def new
    @client_import = ClientImport.new
    @zip_file      = ZipFile.where(identifier: 'contact-file-template.csv').first_or_create(identifier: 'contact-file-template.csv', title: 'contact-file-template.csv')
  end

  def create
    @client_import = ClientImport.create(client_import_params)

    ClientCsvImportWorker.perform_async( @client_import.id, current_user.email )
    redirect_to user_user_control_panel_index_path(@user)
  end
  
  
  
  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def client_import_params
    params.require(:client_import).permit!
  end
end
