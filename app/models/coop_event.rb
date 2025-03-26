class CoopEvent < ApplicationRecord
  has_many :elect_positions
  has_many :event_hubs

  def to_s
    name
  end
end
