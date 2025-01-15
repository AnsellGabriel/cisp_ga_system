class EventHub < ApplicationRecord
  attr_accessor :vote_amount
  validates :vote_code, uniqueness: true
  belongs_to :coop_event
  belongs_to :cooperative
  has_many :participants
  has_many :registrations
  has_many :candidates
  has_many :election

  def to_s 
    cooperative
  end

  

  
end
