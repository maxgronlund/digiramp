json.array!(@publishing_deals) do |publishing_deal|
  json.extract! publishing_deal, :id, :publisher_id, :title, :document_id
  json.url publishing_deal_url(publishing_deal, format: :json)
end
