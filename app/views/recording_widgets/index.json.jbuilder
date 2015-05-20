json.array!(@recording_widgets) do |recording_widget|
  json.extract! recording_widget, :id, :edit, :update
  json.url recording_widget_url(recording_widget, format: :json)
end
