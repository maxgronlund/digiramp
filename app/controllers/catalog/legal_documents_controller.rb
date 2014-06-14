class Catalog::LegalDocumentsController < ApplicationController
  
  include Transloadit::Rails::ParamsDecoder
  include AccountsHelper
  include CatalogsHelper
  
  before_filter :access_account
  before_filter :access_catalog
  
  
  def index
    
  end

  def show
    
  end

  def new
    
  end

  def edit
  end
  
  def create
    forbidden unless current_account_user.create_legal_document
    
  end
end
