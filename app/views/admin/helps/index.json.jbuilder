json.array!(@helps) do |help|
  json.extract! help, :id, :identifier, :button, :title, :body, :snippet
  json.url help_url(help, format: :json)
end
