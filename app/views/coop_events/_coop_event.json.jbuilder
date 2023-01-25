json.extract! coop_event, :id, :name, :event_date, :description, :election, :active, :created_at, :updated_at
json.url coop_event_url(coop_event, format: :json)
