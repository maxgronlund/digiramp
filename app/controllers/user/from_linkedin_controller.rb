class User::FromLinkedinController < ApplicationController
  before_filter :access_user
  include AccountsHelper
  
  def new
    @client_import = ClientImport.new
  end

  def create
    @client_import = ClientImport.create(client_import_params)
    ClientLinkedinImportWorker.perform_async( @client_import.id, current_user.email )
    redirect_to user_user_control_panel_index_path(@user)
  end
  
  
  
  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def client_import_params
    params.require(:client_import).permit!
  end
end

