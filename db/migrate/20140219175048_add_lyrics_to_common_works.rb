class AddLyricsToCommonWorks < ActiveRecord::Migration
  def change
    add_column :common_works, :lyrics, :text
  end
end
