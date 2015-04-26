json.array!(@plans) do |plan|
  json.extract! plan, :id, :stripe_id, :name, :description, :amount, :interval, :published
  json.url plan_url(plan, format: :json)
end
