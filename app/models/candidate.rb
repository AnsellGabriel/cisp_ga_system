class Candidate < ApplicationRecord
  belongs_to :event_hub
  belongs_to :elect_position
  has_many :votes
  has_one_attached :picture
  has_one_attached :resume
  has_one_attached :board_reso
  def get_fullname 
    last_name + ', ' + first_name + ' ' + middle_name
  end
  def to_s 
    get_fullname
  end
  
  def get_vote (event_hub, candidate_id) 
    Vote.find_by(candidate_id: candidate_id, event_hub_id: event_hub)
  end
end
