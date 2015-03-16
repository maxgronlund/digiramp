class AddBackgroundImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :backdrop_image, :string
    
    User.find_each do |user|
      user.page_style_id = PageStyle.first.id
      user.save!
    end
  end
end
 