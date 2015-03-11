json.array!(@page_styles) do |page_style|
  json.extract! page_style, :id, :title, :css_tag, :backdrop_image, :show_backdrop, :bgcolor
  json.url page_style_url(page_style, format: :json)
end
