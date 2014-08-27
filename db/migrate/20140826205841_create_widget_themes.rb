class CreateWidgetThemes < ActiveRecord::Migration
  def change
    create_table :widget_themes do |t|
      t.string :title
      t.string :background_color, default: '#F7F7F7'
      t.string :waveform_back, default: '#D6D6D6'
      t.string :loadbar_color, default: '#999'
      t.string :hover_color, default: '#F7F7F7'
      t.string :heading_color, default: '#999'
      t.string :text_color, default: '#333'
      t.string :border_color, default: '#CCC'
      t.timestamps
    end
  end
end
