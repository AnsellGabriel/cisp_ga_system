json.extract! candidate, :id, :event_hub_id, :elect_position_id, :last_name, :first_name, :middle_name, :suffix, :birth_date, :address, :mobile_number, :email, :education, :company, :occupation, :status, :created_at, :updated_at
json.url candidate_url(candidate, format: :json)
