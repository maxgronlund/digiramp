class CreateCmsNavigationBars < ActiveRecord::Migration
  def change
    create_table :cms_navigation_bars do |t|

      t.timestamps
    end
  end
end
