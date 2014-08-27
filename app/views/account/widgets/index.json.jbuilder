json.array!(@widgets) do |widget|
  json.extract! widget, :id, :title, :body, :image, :secret_key, :width, :height, :catalog_id, :layout
  json.url widget_url(widget, format: :json)
end
