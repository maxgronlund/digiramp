class User::CmsModuleController < ApplicationController
  before_filter :access_user
  def new
    ap params
    #begin
      @position = 0
      @cms_page    = CmsPage.cached_find(params[:cms_page_id]) 
      if last_cms_section  = @cms_page.cms_sections.last
        @possition = last_cms_section.position + 1 if last_cms_section.position
      end
      @column_nr   = params[:column_nr]
      @cms_section = CmsSection.new()
    #rescue
    #  ap '========================='
    #  not_found params
    #end
  end
end
