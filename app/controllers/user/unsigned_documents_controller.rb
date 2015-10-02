class User::UnsignedDocumentsController < ApplicationController
  
  before_action :access_user
  
  def index
    @documents = @user.document_users.where(signed_on: nil).map {|document_user| document_user.document }
    @documents.uniq!
    @documents.compact
  end

  def show
  end

  def edit
  end

  def update
  end
end
