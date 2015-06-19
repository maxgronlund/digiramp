json.array!(@admin_terms) do |admin_term|
  json.extract! admin_term, :id, :title, :body
  json.url admin_term_url(admin_term, format: :json)
end
