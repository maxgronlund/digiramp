json.array!(@fobars) do |fobar|
  json.extract! fobar, :id, :index
  json.url fobar_url(fobar, format: :json)
end
