class User::GmailInvitationsController < ApplicationController
  
  before_action :access_user
  def show
    @client_import = ClientImport.cached_find(params[:id])
  end

  def index
  end
end
