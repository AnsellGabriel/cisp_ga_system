json.extract! election, :id, :event_hub_id, :voter_code, :created_at, :updated_at
json.url election_url(election, format: :json)
