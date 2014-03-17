json.array!(@customers) do |customer|
  json.extract! customer, :id, :name, :email, :phone, :note, :account_id
  json.url customer_url(customer, format: :json)
end
