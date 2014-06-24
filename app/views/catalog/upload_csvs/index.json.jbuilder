json.array!(@upload_csvs) do |upload_csv|
  json.extract! upload_csv, :id, :title, :body, :user_email, :account_id, :catalog_id, :common_works_count
  json.url upload_csv_url(upload_csv, format: :json)
end
