# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# # GEOGRAPHICAL ADDRESS

# spreadsheet = Roo::Spreadsheet.open("./db/uploads/addresses.xlsx")

# (2..spreadsheet.last_row).each do |row|
#     reg = GeoRegion.find_or_initialize_by(name: spreadsheet.cell(row, 'A').strip)
#     puts "#{reg.name}" if reg.save!

#     pro = GeoProvince.find_or_initialize_by(name: spreadsheet.cell(row, 'B').strip)
#     pro.geo_region_id = reg.id
#     puts "#{pro.name}" if pro.save!

#     mun = GeoMunicipality.find_or_initialize_by(name: spreadsheet.cell(row, 'C').strip)
#     mun.geo_region_id = reg.id
#     mun.geo_province_id = pro.id
#     puts "#{mun.name}" if mun.save!

#     bar = GeoBarangay.find_or_initialize_by(name: spreadsheet.cell(row, 'D').strip)
#     bar.geo_region_id = reg.id
#     bar.geo_province_id = pro.id
#     bar.geo_municipality_id = mun.id
#     # bar.psgc_code = spreadsheet.cell(row, 'E')
#     puts "#{bar.name}" if bar.save!
# end
# def generate_code
#     charset = ('A'..'Z').to_a + ('2'..'9').to_a # Excludes I, O, 1, and 0
#     charset -= ['I', 'O'] # Explicitly remove I and O
#     Array.new(5) { charset.sample }.join
# end
# spreadsheet = Roo::Spreadsheet.open("./db/uploads/51st_coop_b1.xlsx")

# (2..spreadsheet.sheet("Sheet1").last_row).each do |row|
#     coop = Cooperative.find_or_initialize_by(name: spreadsheet.cell(row, 'B'))
#     puts "#{coop.name}" if coop.save!

#     vote_code = generate_code
#     eh = EventHub.find_or_initialize_by(cooperative_id: coop.id)
#     eh.code = spreadsheet.cell(row, 'A')
#     eh.coop_event_id = 1
#     eh.vote_code = generate_code
#     eh.capital = 0
#     eh.vote_power = 0
#     puts "#{eh.vote_code}" if eh.save!
# end

# spreadsheet = Roo::Spreadsheet.open("./db/uploads/vote_power_50.xlsx")

# (2..spreadsheet.sheet("Sheet1").last_row).each do |row|
#     coop = Cooperative.find_by(name: spreadsheet.cell(row, 'A'))
#     # puts "NEW COOP -------------------------> #{coop.name}" if coop.save!
#     puts "#{coop.name}"
#     if coop.nil?
#         puts "Invalid Cooperative " & spreadsheet.cell(row, 'A')
#     else
#         eh = EventHub.find_or_initialize_by(cooperative_id: coop.id)
#         eh.capital = spreadsheet.cell(row, 'B')
#         eh.vote_power = spreadsheet.cell(row, 'C')
#         eh.coop_event_id = 1
#         eh.cooperative_id = coop.id
#         eh.voted = 0
#         eh.attend = 0
#         unless EventHub.exists?(cooperative_id: coop.id)
#             loop do
#                     code = SecureRandom.alphanumeric(4).upcase
#                     modified_string = code.gsub(/[1iO0I]/, "A")
#                     if EventHub.exists?(vote_code: modified_string)
#                         puts "Code #{modified_string} already exists, generating new code..."
#                     else
#                         eh.vote_code = modified_string
#                     break
#                     end
#             end
#         end
#         puts "#{coop.name} - #{eh.vote_code}" if eh.save!
#     end

# COOP TECH IMPORT
spreadsheet = Roo::Spreadsheet.open("./db/uploads/capital_2024_final.xlsx")

(2..spreadsheet.sheet("Sheet1").last_row).each do |row|
  coop = Cooperative.find_or_initialize_by(name: spreadsheet.cell(row, "B").strip)
  puts "SAVED --- #{coop.name}" if coop.save!
  # eh = coop.event_hub
  if coop.event_hub.present?
    eh = coop.event_hub
    if eh.capital == 0
      eh.update!(capital: spreadsheet.cell(row, "C"), vote_power: spreadsheet.cell(row, "D"))
      puts "#{coop.name}"
    end
  else
    eh = EventHub.find_or_initialize_by(cooperative: coop)
    eh.capital = spreadsheet.cell(row, "C")
    eh.vote_power = spreadsheet.cell(row, "D")
    coop_event = CoopEvent.find_by(active: 1)
    eh.coop_event = coop_event
    loop do
      code = SecureRandom.alphanumeric(4).upcase
      modified_string = code.gsub(/[1iO0I]/, "A")
      if EventHub.exists?(vote_code: modified_string)
        puts "Code #{modified_string} already exists, generating new code..."
      else
        eh.vote_code = modified_string
        break
      end
    end
    puts "#{eh.vote_code} - #{eh.cooperative}" if eh.save!
    # puts "#{spreadsheet.cell(row, "B")}"
  end
  #     puts "#{coop.name}"
  #     eh = EventHub.find_by(cooperative_id: coop.id)

  #     reg = Registration.find_or_initialize_by(event_hub_id:  eh.id, last_name: spreadsheet.cell(row, 'H'))
  #     reg.last_name = spreadsheet.cell(row, 'H')
  #     reg.first_name = spreadsheet.cell(row, 'I')
  #     reg.middle_name = ""
  #     reg.email = spreadsheet.cell(row, 'D')
  #     reg.mobile_number = spreadsheet.cell(row, 'E')
  #     reg.guest_type = spreadsheet.cell(row, 'F')
  #     reg.attendance = spreadsheet.cell(row, 'G')
  #     if reg.save
  #         puts "----Reg--#{reg.last_name}, #{reg.first_name}"
  #         # RegisterMailer.with(registration: reg, event_hub: eh).register_created.deliver_later
end

## SEED CANDIDATES FAKKER
# event = CoopEvent.find_by(active: 1)
# 10.times do
#   c = Candidate.create!(
#     last_name: FFaker::Name.last_name,
#     first_name: FFaker::Name.first_name,
#     middle_name: FFaker::Name.name[0],
#     suffix: "",
#     email: FFaker::Name.last_name + "@email.com",
#     coop_event_id: event.id,
#     elect_position: event.elect_positions.sample,
#     event_hub: EventHub.all.sample,
#   )
#   puts "#{c.last_name} - #{c.event_hub.cooperative} has been created!"
# end
