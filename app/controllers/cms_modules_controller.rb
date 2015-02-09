class CmsModulesController < ApplicationController
  

  # GET /cms_pages/1
  # GET /cms_pages/1.json
  def show
    ap params
    @cms_section = params[:id]
  end

  # GET /cms_pages/new
  
end
