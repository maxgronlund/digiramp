json.array!(@publishers) do |publisher|
  json.extract! publisher, :id, :user, :email,, :phone_number,, :ipi_code,, :cae_code, :uuid, :pro_affiliation, :status
  json.url publisher_url(publisher, format: :json)
end
