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
      puts "#####{@event_hub.vote_code}"
      event_hub_id = @event_hub.id
    end
  end

end
