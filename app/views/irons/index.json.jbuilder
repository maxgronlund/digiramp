json.array!(@irons) do |iron|
  json.extract! iron, :id, :title
  json.url iron_url(iron, format: :json)
end
