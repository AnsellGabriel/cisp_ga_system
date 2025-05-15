class Registration < ApplicationRecord
  belongs_to :event_hub
  validates_presence_of :last_name, :first_name, :guest_type, :email, :dietary, :mobile_number, :attendance, :size
  # validates_presence_of :mobile_number, :size
  # validates_presence_of :coop_tin, on: :create
  # validates :guest_type, :attendance, presence: :true
  attr_accessor :coop_tin

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :check_principal
  # validate :check_attached_board_reso
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
        errors.add(:base, "Principal delegate already registered")
      end
    end
    # if guest_type == "Young Coop leader"
    #   #  puts "@@@@@ check #{guest_type}"
    #   @principal = Registration.find_by(event_hub_id: "#{event_hub_id}", guest_type: "#{guest_type}")
    #   unless @principal.nil?
    #     errors.add(:base,"Young Coop Leader already registered")
    #   end
    # end
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
    elsif guest_type == "Young Coop leader"
      unless id_pic.attached?
        errors.add(:base, "Must attached an ID")
      end
    end
  end

  def self.to_csv
    CSV.generate(col_sep: ";") do |csv|
      csv << ["id", "coop", "last_name", "first_name", "middle_name", "birth_date", "mobile_no", "email", "guest_type", "attend", "price", "paid", "area", "attendance", "position", "registered", "voted", "vote_code", "number_votes"]
      all.find_each do |reg|
        csv << [reg.id, reg.event_hub.cooperative.name, reg.last_name, reg.first_name, reg.middle_name, reg.birth_date, reg.mobile_number, reg.email, reg.guest_type, reg.attend, reg.price, reg.paid, reg.size, reg.attendance, reg.dietary, reg.created_at, reg.event_hub.voted, reg.event_hub.vote_code, reg.event_hub.vote_amount]
      end
    end
  end

  Attendance = ["I will attend physically in the venue",
                "I will attend virtually via zoom",
                "I will attend virtually and will avail AGA kit (will shoulder shipping cost)"]

  # Size = [ "XXXL", "XXL", "XL", "Large", "Medium", "Small", "X-Small"]
  Size = ["Face to Face", "Virtual Zoom Meeting"]

  # GuestType = ["Principal Delegate", "Accompanying Delegate", "Young Coop leader"]
  GuestType = ["Principal Delegate", "Accompanying Delegate"]
  Area = ["NCR", "Luzon", "Visayas", "Mindanao"]
  # Dietary = ["None", "Halal", "Vegetarian", "Vegan"]

  Gender = ["Male", "Female", "Others"]

  def get_fullname
    first_name + " " + middle_name + " " + last_name
  end
end
