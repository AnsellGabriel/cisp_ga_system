json.extract! vote, :id, :event_hub_id, :coop_event_id, :candidate_id, :vote_amount, :vote_entry, :post, :created_at, :updated_at
json.url vote_url(vote, format: :json)
