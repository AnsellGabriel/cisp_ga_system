class Vote < ApplicationRecord
  validates :vote_amount, presence: true
  belongs_to :event_hub, optional: true
  belongs_to :coop_event, optional: true
  belongs_to :candidate, optional: true
  belongs_to :elect_position, optional: true
  attr_accessor :entry_vote

  
  validates :vote_amount, numericality: { only_integer: true }
  validate :validate_vote_amount, :on => :create
  validate :validate_vote_amount_edit, :on => :update

  def validate_vote_amount 
    if vote_amount > entry_vote
      errors.add(:base,"Vote amount must not exceed " + entry_vote.to_s)
    end
    if vote_amount <= 0 
      errors.add(:base,"Vote amount must be greater than 0")
    end
    @count_vote = Vote.where(elect_position_id: elect_position_id, event_hub_id: event_hub_id).count
    @max_vote = ElectPosition.find(elect_position_id).vacant
    if @count_vote == @max_vote
      errors.add(:base,"You already voted " + @count_vote.to_s + " candidate.")
    end
  end
  def validate_vote_amount_edit
    if vote_amount > entry_vote
      errors.add(:base,"Vote amount must not exceed " + entry_vote.to_s)
    end
    if vote_amount <= 0 
      errors.add(:base,"Vote amount must be greater than 0")
    end
    @coop_event = CoopEvent.find(coop_event_id)
    unless @coop_event.election 
      errors.add(:base,"Election is now close")
    end
  end
  # validates :vote_amount, numericality: { less_than_or_equal_to: "%{:entry_vote}" }
end
