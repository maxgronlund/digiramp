json.array!(@submissions) do |submission|
  json.extract! submission, :id, :opportunity_id, :account_id, :user_id, :recording_id, :title, :body, :rating
  json.url submission_url(submission, format: :json)
end
