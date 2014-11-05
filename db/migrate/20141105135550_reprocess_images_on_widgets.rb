class ReprocessImagesOnWidgets < ActiveRecord::Migration
  def change
    
    Widget.find_each do |widget|
      begin
        widget.image.recreate_versions!
      rescue
        puts 'no image'
      end
    end
    
    
  end
end
