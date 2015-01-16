json.array!(@zip_files) do |zip_file|
  json.extract! zip_file, :id, :title, :body, :zip_file
  json.url zip_file_url(zip_file, format: :json)
end
