json.array!(@events) do |event|
  json.extract! event, :name, :description, :total_balance, :organizer
  json.url event_url(event, format: :json)
end
