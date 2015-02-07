class User::CmsModuleMovesController < ApplicationController
  before_filter :access_user
  def update
    cms_section   = CmsSection.cached_find(params[:cms_section_id])
    @column_nr    = cms_section.column_nr
    @cms_page     = CmsPage.cached_find(params[:cms_page_id])
    
    @cms_page.cms_sections.order(:position).where(column_nr: cms_section.column_nr).each do |section|
      
      if section.position == cms_section.position - 1
        section.position += 1
        section.save!
        cms_section.position -= 1
        cms_section.save!
      end
    end
  end
end
