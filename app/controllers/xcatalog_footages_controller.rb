class CatalogFootagesController < ApplicationController
  
  include AccountsHelper
  include CatalogsHelper
  before_filter :access_account, only: [:show, :destroy]
  before_filter :access_catalog,    only: [:show, :destroy]

  # GET /catalog_footages
  # GET /catalog_footages.json
  def index
   
  end

  # GET /catalog_footages/1
  # GET /catalog_footages/1.json
  def show
  end

  # GET /catalog_footages/new
  def new
    
  end

  # GET /catalog_footages/1/edit
  def edit
  end

  # POST /catalog_footages
  # POST /catalog_footages.json
  def create
    
  end

  # PATCH/PUT /catalog_footages/1
  # PATCH/PUT /catalog_footages/1.json
  def update
   
  end

  # DELETE /catalog_footages/1
  # DELETE /catalog_footages/1.json
  def destroy
    
  end

end
