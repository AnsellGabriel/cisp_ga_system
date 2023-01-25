json.extract! registration, :id, :event_hub_id, :last_name, :first_name, :middle_name, :birth_date, :mobile_number, :email, :guest_type, :attendance, :created_at, :updated_at
json.url registration_url(registration, format: :json)
