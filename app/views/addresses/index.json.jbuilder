json.array!(@addresses) do |address|
  json.extract! address, :id, :first_name, :last_name, :address_line_1, :address_line_2, :city, :state, :country, :addressable_id, :addressable_type
  json.url address_url(address, format: :json)
end
