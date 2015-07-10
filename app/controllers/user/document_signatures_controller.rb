class User::DocumentSignaturesController < ApplicationController
  before_action :access_user
  def index
    @document = Document.cached_find(params[:legal_document_id])
  end
  
  
  def edit
  end
end
