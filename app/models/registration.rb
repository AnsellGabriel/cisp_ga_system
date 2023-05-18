class Registration < ApplicationRecord
  belongs_to :event_hub
  validates_presence_of :last_name, :first_name, :guest_type, :attendance, :email, :mobile_number
  validates_presence_of :coop_tin, :on => :create
  # include GenerateCsv
  require 'csv'
  # validates :guest_type, :attendance, presence: :true
  attr_accessor :coop_tin

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :check_principal, :on => :create
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

  def self.to_csv(collection) 
    CSV.generate do |csv|
      csv << [ "id", "name", "cooperative", "attend_date", "guest_type" ]
      collection.find_each do |record| 
        csv << [ record.id, record.get_fullname, record.event_hub.cooperative.name, record.attend_date, record.guest_type ]
      end
    end
  end
  
  Attendance = [  "I will attend physically in the venue",
    "I will attend virtually via zoom",
    "I will attend virtually and will avail AGA kit (will shoulder shipping cost)"]
    
  GuestType = ["Principal Delegate", "Accompanying Delegate", "Young Coop leader"]
  def get_fullname 
      first_name + ' ' + middle_name + ' ' + last_name 
  end
end
