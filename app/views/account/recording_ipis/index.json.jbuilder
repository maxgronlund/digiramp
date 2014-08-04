json.array!(@recording_ipis) do |recording_ipi|
  json.extract! recording_ipi, :id, :role, :name, :share, :user_id, :user_uuid, :recording_id
  json.url recording_ipi_url(recording_ipi, format: :json)
end
