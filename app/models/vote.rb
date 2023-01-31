class Vote < ApplicationRecord
  validates :vote_amount, presence: true
  belongs_to :event_hub, optional: true
  belongs_to :coop_event, optional: true
  belongs_to :candidate, optional: true
  attr_accessor :entry_vote

  
  # validates :vote_amount, numericality: { less_than_or_equal_to: :entry_vote }
  # validates :vote_amount, numericality: { only_integer: true }
end
