class CoopEvent < ApplicationRecord
  has_many :elect_positions
  has_many :event_hubs
  has_many :candidates

  def to_s
    name
  end
end
