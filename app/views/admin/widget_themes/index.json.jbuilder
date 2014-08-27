json.array!(@widget_themes) do |widget_theme|
  json.extract! widget_theme, :id, :background_color, :waveform_back, :hover_color, :heading_color, :text_color, :border_color, :text_color
  json.url widget_theme_url(widget_theme, format: :json)
end
