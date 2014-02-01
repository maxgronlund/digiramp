class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.text     "big_banner_text"
      t.string   "box_1_title"
      t.text     "box_1_body"
      t.string   "box_1_link"
      
      t.string   "box_2_title"
      t.text     "box_2_body"
      t.string   "box_2_link"
      
      t.string   "box_3_title"
      t.text     "box_3_body"
      t.string   "box_3_link"
      
      
      t.timestamps
    end
  end
end
