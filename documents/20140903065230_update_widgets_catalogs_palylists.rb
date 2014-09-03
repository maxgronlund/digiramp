class UpdateWidgetsCatalogsPalylists < ActiveRecord::Migration
  def up
    Widget.all.each do |widget|
      puts '............... update layout ................'
      widget.widget_theme_id = widget.layout.to_i
      widget.save!
    end
    
    Catalog.all.each do |catalog|
      catalog.add_default_widget
    end
    
    Playlist.all.each do |playlist|
      playlist.user_id = playlist.account.user_id
      playlist.save!
      playlist.add_default_widget
    end
  end
  
  def down
    Playlist.all.each do |playlist|
      widget = Widget.where(secret_key: playlist.default_widget_key).first
      widget.destroy
    end
    #
    Catalog.all.each do |catalog|
      widget = Widget.where(secret_key: catalog.default_widget_key).first
      widget.destroy
    end
  end
end
