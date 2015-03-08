class ResortCmsSections < ActiveRecord::Migration
  def change
    CmsPage.find_each do |cms_page|
      cms_page.cms_sections.order(:position).where(column_nr: 0).each_with_index do |section, index|
        section.position = index
        section.save!
      end
    end
    
  end
end
