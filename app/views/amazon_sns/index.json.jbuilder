json.array!(@amazon_sns) do |amazon_sn|
  json.extract! amazon_sn, :id, :title
  json.url amazon_sn_url(amazon_sn, format: :json)
end
