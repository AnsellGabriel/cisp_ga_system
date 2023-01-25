class Candidate < ApplicationRecord
  belongs_to :event_hub
  belongs_to :elect_position
  has_one_attached :picture
  has_one_attached :resume
  has_one_attached :board_reso
  def get_fullname 
    last_name + ', ' + first_name + ' ' + middle_name
  end
end
