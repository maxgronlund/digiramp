json.array!(@documents) do |document|
  json.extract! document, :id, :title, :body, :file, :transloadit, :account_id
  json.url document_url(document, format: :json)
end
