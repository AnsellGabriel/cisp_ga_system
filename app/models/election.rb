class Election < ApplicationRecord
  validates_presence_of :voter_code
  belongs_to :event_hub, optional: true
  belongs_to :coop_event, optional: true

  validate :check_voter_code

  def check_voter_code
    @coop_event = CoopEvent.find_by(active: 1)
    @event_hub = @coop_event.event_hubs.find_by(vote_code: "#{voter_code}")
    # @event_hub = EventHub.find_by(vote_code: "#{voter_code}")
    unless @coop_event.election
      errors.add(:base, "Election is now close")
    else
      if @event_hub.nil?
        errors.add(:base, "Voter code not valid")
      end
      if @event_hub.voted
        errors.add(:base, "Member already voted")
      end
      event_hub_id = @event_hub.id
    end
  end
end
