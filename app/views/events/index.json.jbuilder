json.array!(@events) do |event|
  json.extract! event, :fb_eid, :name, :description, :start_time, :end_time, :location, :picture, :ticket_uri
  json.url event_url(event, format: :json)
end
