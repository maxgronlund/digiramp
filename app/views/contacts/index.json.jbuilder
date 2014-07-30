json.array!(@contacts) do |contact|
  json.extract! contact, :id, :email, :title, :body
  json.url contact_url(contact, format: :json)
end
