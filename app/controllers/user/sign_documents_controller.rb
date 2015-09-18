class User::SignDocumentsController < ApplicationController
  
  before_action :access_user
  
  def show
    @document = Document.cached_find(params[:id])
  end

  def update
    ap params
    if digital_signature = @user.digital_signature
      document_user = DocumentUser.cached_find(params[:id])
      document_user.update(digital_signature_id: digital_signature.id, signed_on: Date.today)
    end
    redirect_to :back
  end
end
