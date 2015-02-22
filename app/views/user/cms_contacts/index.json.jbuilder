json.array!(@user_cms_contacts) do |user_cms_contact|
  json.extract! user_cms_contact, :id, :message
  json.url user_cms_contact_url(user_cms_contact, format: :json)
end
