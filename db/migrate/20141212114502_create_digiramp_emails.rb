class CreateDigirampEmails < ActiveRecord::Migration
  def change
    create_table :digiramp_emails do |t|
      t.belongs_to :email_group, index: true
      t.string :subject         , default: ''
      t.string :layout          , default: ''
      t.string :title_1         , default: ''
      t.string :title_2         , default: ''
      t.string :title_3         , default: ''
      t.text :body_1            , default: ''
      t.text :body_2            , default: ''
      t.text :body_3            , default: ''
      t.string :image_1         , default: ''
      t.string :image_2         , default: ''
      t.string :image_3         , default: ''
      t.string :link_1          , default: ''
      t.string :link_1_title    , default: ''
      t.string :link_2          , default: ''
      t.string :link_2_title    , default: ''
      t.string :link_3          , default: ''
      t.string :link_3_title    , default: ''

      t.text :recipients  , default: ''
      t.boolean :delivered, default: false
      #t.date :send

      t.timestamps
    end
  end
end

