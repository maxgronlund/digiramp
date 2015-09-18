class User::LegalDocumentUsersController < ApplicationController
  before_action :access_user
  
  def new
  end

  def create
  end

  def edit
    ap params
    #@document = Document.cached_find(params[:id])
  end

  def update
  end

  def destroy
  end
end
