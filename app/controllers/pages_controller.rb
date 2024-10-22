class PagesController < ApplicationController
    def home 
        @coop_events = CoopEvent.where(:active => 1)
        # @coop = Cooperative.all
    end
    def election 
        @coop_events = CoopEvent.where(active: 1)
    end
    def vote 
        @election = Election.new
        @coop_event = CoopEvent.find_by(:active => 1)
    end

    def coming_soon 

    end
    def announcement 
        
    end
    def coop 
        # @event_hub = EventHub.where(coop_event_id: coop_event.id)
    end

    def event_hub 
        #  raise "errors"
         @event_hub = EventHub.find(params[:id])
    end
    def show 
        @event_hub = EventHub.where(coop_event_id: params[1])
    end

    def register 
        @registration = Registration.new
        set_dummy_register
    end
    def set_dummy_register 
        @registration.last_name = FFaker::Name.last_name
        @registration.first_name = FFaker::Name.first_name
        @registration.middle_name = FFaker::Name.name[0]
        @registration.email = @registration.last_name + "@email.com"
        @event_hub = EventHub.all
        @registration.event_hub_id = @event_hub.shuffle.first.id
    end
end
