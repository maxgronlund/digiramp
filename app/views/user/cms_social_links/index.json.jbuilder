json.array!(@cms_social_links) do |cms_social_link|
  json.extract! cms_social_link, :id, :position, :user_id
  json.url cms_social_link_url(cms_social_link, format: :json)
end
