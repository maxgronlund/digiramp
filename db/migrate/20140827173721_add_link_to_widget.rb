class AddLinkToWidget < ActiveRecord::Migration
  def change
    add_column :widgets, :widget_link, :string
    add_column :widgets, :show_headder, :boolean, default: false
    add_column :widgets, :title_color, :string, default: '#888'

  end
end
