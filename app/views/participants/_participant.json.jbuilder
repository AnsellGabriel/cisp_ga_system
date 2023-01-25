json.extract! participant, :id, :event_hub_id, :last_name, :first_name, :middle_name, :birth_date, :mobile_number, :email, :guest_type, :attendance_channel, :created_at, :updated_at
json.url participant_url(participant, format: :json)
