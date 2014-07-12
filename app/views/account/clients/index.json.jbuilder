json.array!(@clients) do |client|
  json.extract! client, :id, :account_id, :user_uuid, :name, :last_name, :user_uuid, :title, :photo, :telephone_home, :telephone_work, :address_home, :address_home, :email, :revision
  json.url client_url(client, format: :json)
end
