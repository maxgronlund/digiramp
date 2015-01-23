json.array!(@raw_images) do |raw_image|
  json.extract! raw_image, :id, :identifier, :title, :image
  json.url raw_image_url(raw_image, format: :json)
end
