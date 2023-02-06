class Election < ApplicationRecord
  validates_presence_of :voter_code
  belongs_to :event_hub, optional: true
  belongs_to :coop_event, optional: true

   validate :check_voter_code

  def check_voter_code
    @event_hub = EventHub.find_by(coop_event_id: "#{coop_event_id}", vote_code: "#{voter_code}")
    if @event_hub.nil?
      errors.add(:base,"Voter code not valid")
    else
      @coop_event = CoopEvent.find(coop_event_id)
      unless @coop_event.election 
        errors.add(:base,"Election is now close")
      end
      if @event_hub.voted 
        errors.add(:base,"Cooperative already voted")
      end
      event_hub_id = @event_hub.id
    end
  end

end
