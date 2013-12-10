json.array!(@places) do |place|
  json.extract! place, :street, :city, :state, :country, :zip, :latitude, :longitude, :name, :event_id
  json.url place_url(place, format: :json)
end
