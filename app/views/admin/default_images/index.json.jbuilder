json.array!(@default_images) do |default_image|
  json.extract! default_image, :id, :recording_artwork, :user_avatar, :company_logo
  json.url default_image_url(default_image, format: :json)
end
