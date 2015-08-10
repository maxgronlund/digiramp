json.array!(@professional_infos) do |professional_info|
  json.extract! professional_info, :id, :ipi_code
  json.url professional_info_url(professional_info, format: :json)
end
