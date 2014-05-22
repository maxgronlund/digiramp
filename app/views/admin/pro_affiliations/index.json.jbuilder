json.array!(@pro_affiliations) do |pro_affiliation|
  json.extract! pro_affiliation, :id, :country, :web, :title
  json.url pro_affiliation_url(pro_affiliation, format: :json)
end
