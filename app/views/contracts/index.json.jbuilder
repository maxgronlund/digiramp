json.array!(@contracts) do |contract|
  json.extract! contract, :id, :title, :subject
  json.url contract_url(contract, format: :json)
end
