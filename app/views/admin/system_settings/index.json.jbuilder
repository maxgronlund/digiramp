json.array!(@system_settings) do |system_setting|
  json.extract! system_setting, :id, :recording_artwork_id, :user_avatar_id, :company_logo_id
  json.url system_setting_url(system_setting, format: :json)
end
