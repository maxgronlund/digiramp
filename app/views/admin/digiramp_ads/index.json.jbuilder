json.array!(@digiramp_ads) do |digiramp_ad|
  json.extract! digiramp_ad, :id, :identifyer, :title, :body, :image, :snippet, :link, :button_link, :button_style, :css_snipet
  json.url digiramp_ad_url(digiramp_ad, format: :json)
end
