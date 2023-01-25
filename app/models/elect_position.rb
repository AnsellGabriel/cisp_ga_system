class ElectPosition < ApplicationRecord
  belongs_to :coop_event
  def to_s 
    name
  end
end
