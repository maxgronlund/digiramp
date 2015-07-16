json.array!(@admin_legal_tags) do |admin_legal_tag|
  json.extract! admin_legal_tag, :id, :title, :body
  json.url admin_legal_tag_url(admin_legal_tag, format: :json)
end
