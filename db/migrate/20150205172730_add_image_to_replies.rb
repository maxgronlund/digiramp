class AddImageToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :image, :string
  end
end
