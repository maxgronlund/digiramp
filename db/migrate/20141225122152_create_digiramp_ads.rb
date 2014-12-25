class CreateDigirampAds < ActiveRecord::Migration
  def change
    create_table :digiramp_ads do |t|
      t.string :identifyer
      t.string :title
      t.text :body
      t.string :image
      t.string :snippet
      t.string :link
      t.string :button_link
      t.string :button_style
      t.text :css_snipet

      t.timestamps
    end
  end
end
