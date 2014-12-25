class AddShowImageToDigirampAds < ActiveRecord::Migration
  def change
    add_column :digiramp_ads, :show_image, :boolean
    add_column :digiramp_ads, :button_text, :string
    add_column :digiramp_ads, :button_icon, :string
  end
end
