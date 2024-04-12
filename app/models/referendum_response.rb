class ReferendumResponse < ApplicationRecord
  belongs_to :event_hub
  belongs_to :referendum
end
