class AddIdentifyerToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :identifyer, :string
  end
end
