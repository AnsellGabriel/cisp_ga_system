class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :coop_event

  def coop_event
    @my_coop_event = CoopEvent.find_by(:active => 1)
  end
end
