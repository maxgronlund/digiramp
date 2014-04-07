json.array!(@genre_imports) do |genre_import|
  json.extract! genre_import, :id, :file
  json.url genre_import_url(genre_import, format: :json)
end
