json.extract! referendum_response, :id, :event_hub_id, :referendum_id, :response, :created_at, :updated_at
json.url referendum_response_url(referendum_response, format: :json)
