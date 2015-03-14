class AddShowInMenuToCmsPages < ActiveRecord::Migration
  def change
    add_column :cms_pages, :show_in_menu, :boolean, default: false
    add_column :cms_pages, :position, :integer, default: true
    add_reference :cms_pages, :cms_page, index: true
    
    User.find_each do |user|
      user.cms_pages.each_with_index do |cms_page, index|
        cms_page.show_in_menu = true
        cms_page.position     = index
        cms_page.save!
      end
    end
  end

end
