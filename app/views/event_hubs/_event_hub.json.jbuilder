json.extract! event_hub, :id, :coop_event_id, :cooperative_id, :capital, :vote_power, :vote_code, :created_at, :updated_at
json.url event_hub_url(event_hub, format: :json)
