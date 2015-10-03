class User::UnsignedDocumentsController < ApplicationController
  
  before_action :access_user
  
  def index
    document_ids = @user.document_users
                        .where(signed_on: nil)
                        .map {|document_user| document_user.document_id  unless document_user.document_id.nil?}
    
    document_ids.uniq!

    @documents = Document.order(:title).where(uuid: document_ids)
  end

  def show
  end

  def edit
  end

  def update
  end
end
