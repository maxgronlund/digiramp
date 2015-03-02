json.array!(@issue_events) do |issue_event|
  json.extract! issue_event, :id, :title, :data, :subject_id, :subject_type
  json.url issue_event_url(issue_event, format: :json)
end
