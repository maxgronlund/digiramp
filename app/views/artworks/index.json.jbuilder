json.array!(@artworks) do |artwork|
  json.extract! artwork, :id, :title
  json.url artwork_url(artwork, format: :json)
end
