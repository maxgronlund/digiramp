class User::SelectTemplatesController < ApplicationController
  before_action :access_user
  def index
    @documents   = Document.templates
  end
  
  def show
    @document = Document.cached_find(params[:id])
    redirect_to new_user_user_legal_document_path(uuid: params[:id]) unless params[:preview]
  end
  
  
end
