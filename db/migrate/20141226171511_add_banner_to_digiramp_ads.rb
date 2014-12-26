class AddBannerToDigirampAds < ActiveRecord::Migration
  def change
    add_column :digiramp_ads, :banner, :string
    add_column :digiramp_ads, :show_banner, :boolean, default: false
  end
end
