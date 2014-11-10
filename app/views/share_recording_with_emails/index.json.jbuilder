json.array!(@share_recording_with_emails) do |share_recording_with_email|
  json.extract! share_recording_with_email, :id, :user_id, :recording_id, :recipients, :title, :message
  json.url share_recording_with_email_url(share_recording_with_email, format: :json)
end
