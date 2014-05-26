json.array!(@footages) do |footage|
  json.extract! footage, :id, :title, :body, :transloadet, :thumb, :uuid, :mp4_file, :webm_file, :copyright, :footagable_type, :footageable_id
  json.url footage_url(footage, format: :json)
end
