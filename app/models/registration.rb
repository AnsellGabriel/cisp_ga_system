class Registration < ApplicationRecord
  belongs_to :event_hub
  validates_presence_of :last_name, :first_name, :guest_type, :attendance, :email, :mobile_number, :coop_tin
  # validates :guest_type, :attendance, presence: :true
  attr_accessor :coop_tin

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :check_principal
  validate :check_attached_board_reso
  has_one_attached :id_pic
  has_one_attached :board_reso

  def to_s 
    event_hub.cooperative
  end
  def check_principal 
    if guest_type == "Principal Delegate"
      #  puts "@@@@@ check #{guest_type}"
      @principal = Registration.find_by(event_hub_id: "#{event_hub_id}", guest_type: "#{guest_type}")
      unless @principal.nil?
        errors.add(:base,"Principal delegate already registered")
      end
    end
  end
  def check_attached_board_reso
    # rails "errors"
    if guest_type == "Principal Delegate"
      unless board_reso.attached? 
        errors.add(:base, "Must attached a board reso")
      end
      unless id_pic.attached? 
        errors.add(:base, "Must attached an ID")
      end
    elsif guest_type == "Young Coop leader (35yo and below)"
      unless id_pic.attached? 
        errors.add(:base, "Must attached an ID")
      end
    end
  end

  
  Attendance = [  "I will attend physically in the venue",
    "I will attend virtually via zoom",
    "I will attend virtually and will avail AGA kit (will shoulder shipping cost)"]
    
  GuestType = ["Principal Delegate", "Accompanying Delegate", "Young Coop leader (35yo and below)"]
  def get_fullname 
      first_name + ' ' + middle_name + ' ' + last_name 
  end
end
