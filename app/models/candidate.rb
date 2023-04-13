class Candidate < ApplicationRecord
  belongs_to :event_hub
  belongs_to :elect_position
  has_many :votes
  has_one_attached :picture
  has_one_attached :resume
  has_one_attached :board_reso
  validates_presence_of :last_name, :first_name
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  def get_fullname 
    first_name + ' ' + middle_name + ' ' + last_name + ' ' + suffix
  end
  def to_s 
    get_fullname 
  end
  
  def get_vote (event_hub, candidate_id)
    Vote.find_by(candidate_id: candidate_id, event_hub_id: event_hub)
  end

  def validate_attachment
    unless board_reso.attached? 
      errors.add(:base, "Must attached a board resolution")
    end
    unless resume.attached?  
      errors.add(:base, "Please attach your application form for candidacy")
    end
    unless picture.attached? 
      errors.add(:base, "Please attached a 2x2 picture")
    end
  end
end
