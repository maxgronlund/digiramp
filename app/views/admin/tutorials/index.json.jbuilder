json.array!(@instructions) do |instruction|
  json.extract! instruction, :id, :title, :body, :video, :views, :tag, :position, :link
  json.url instruction_url(instruction, format: :json)
end
